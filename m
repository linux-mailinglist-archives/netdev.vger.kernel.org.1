Return-Path: <netdev+bounces-247824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D39ADCFF561
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 19:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C14B35E855C
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 17:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED0333AD9E;
	Wed,  7 Jan 2026 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrSJNdTq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134A2349B13;
	Wed,  7 Jan 2026 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804337; cv=none; b=lcpfzSSlsbxH+cW0cU9Ifu1m3QIMzTarelRN0JkMszDVW3ExcZbD5tdViH9yHVSaLSb4fz1FZWUNWaCgHQZPBoMdKyricZkSaCrHDeBJWX5Y7sKy4n+agWq2FIum+SDLhDBizph6wptKsYz6Sg4vb68FZnUkxv7GCzE+WgvqfKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804337; c=relaxed/simple;
	bh=HIZ9CTJOfeSjf+nCMfhA82NoiSEjyTebqQQTfLZlfEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8B/CDprHC17cmc1TolExGCxp2VlzI+BxJSr7rNndWhjJlhp35gsOIpw4Zv0HyWiMOwYEYwEJ3bK5WDcRJKWESE+osAN1X29aG46+NGC6JxF98A0S5bHR5L8LPNqRgEwBq1KuvO8InMGb5dKBmDAUgZiWLTZX4EzN1vRfvu14TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrSJNdTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8324EC4CEF1;
	Wed,  7 Jan 2026 16:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767804336;
	bh=HIZ9CTJOfeSjf+nCMfhA82NoiSEjyTebqQQTfLZlfEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VrSJNdTqW2zjaAuaBkXrHqevbmC+n6m38T/IAe7MbtouLpKCBqYPGDzt3SD/lKiII
	 WhA+tWTFIYaZ4q0UONRC1i5kMqptASQ7u2enyN5CimCL2XRf7n24KCHJKOFA1KjrJp
	 35CRZufMeSAPzCzs6za7eXDwCatVjez80YJphegzUlPp8j5slB/hDA5sSI2y5SSJdE
	 75vvutpS4vC7BW2tp2SnTG0umtAa2zX/i5wTayTAMetq+mL91zjw33/iF5dalcxUj0
	 i/nZVzxeZa2Vzkdz1I6eKrhHWj8hgBXTIxFhoyVGXI30OHvUa63gKNAWdNAMEFcOxz
	 On/lrJUItH44w==
Date: Wed, 7 Jan 2026 08:45:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Gal
 Pressman <gal@nvidia.com>, Jan Stancek <jstancek@redhat.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Nimrod Oren <noren@nvidia.com>,
 netdev@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?B?QXNi?=
 =?UTF-8?B?asO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?= <ast@fiberby.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, Ruben Wauters <rubenru09@aol.com>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 13/13] tools: ynl-gen-c: Fix remaining
 pylint warnings
Message-ID: <20260107084534.11dcb921@kernel.org>
In-Reply-To: <20260107122143.93810-14-donald.hunter@gmail.com>
References: <20260107122143.93810-1-donald.hunter@gmail.com>
	<20260107122143.93810-14-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Jan 2026 12:21:43 +0000 Donald Hunter wrote:
> -                     'return ynl_submsg_failed(yarg, "%s", "%s");' %
> -                        (self.name, self['selector']),
> -                    f"if ({self.nested_render_name}_parse(&parg, {sel_var}, attr))",
> +                     f'return ynl_submsg_failed(yarg, "{self.name}", "{self['selector']}");',
> +                     f"if ({self.nested_render_name}_parse(&parg, {sel_var}, attr))",

This one breaks build of tools/ with old Python, unfortunately:

  File "/home/virtme/testing/wt-24/tools/net/ynl/generated/../pyynl/ynl_gen_c.py", line 946
    f'return ynl_submsg_failed(yarg, "{self.name}", "{self['selector']}");',
                                                            ^
SyntaxError: f-string: unmatched '['
make[2]: *** [Makefile:48: psp-user.c] Error 1
make[1]: *** [Makefile:28: generated] Error 2
make: *** [../../net/ynl.mk:31: /home/virtme/testing/wt-24/tools/testing/selftests/drivers/net/libynl.a] Error 2
-- 
pw-bot: cr

