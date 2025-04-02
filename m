Return-Path: <netdev+bounces-178840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4A6A79294
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7A7170DB1
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F95139CF2;
	Wed,  2 Apr 2025 16:00:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7612917555;
	Wed,  2 Apr 2025 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743609648; cv=none; b=s5yGj14tL0Uk+9ljhPgWZhLKqKG/7vrJ1KBbIX20kCRzszNubzCVdjjBohgbVEY9l5iNhKOoKqTUvCVis5a6Fh0F8casg3yGcVGh1A5NW6FYSq5MuoSWHMMB5UVM2uO3xHq9ZfVYvpcTZYlATTbG3ox8y9Fua43A74QycL6jBys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743609648; c=relaxed/simple;
	bh=F64onNLt2w+tibZxIY7uH0D8/mcd+XRJO+M4Fp+BG8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QolNdK5VWAUj/yxRqP0jpzY8XNY66x5kyNrPe2FQ3Y4LTX2olIt/SlkHyWIFIR/6vUirGRWB5hoQ41zqn0ZXeJP6BsZJV8K2ALVJT+RlGWmYCUnGgAsx8VMWtptjLZ44vx2XSzIJcuoWluwDJt5i/pamHLwGibafGjG296i/2Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1C2C4CEE5;
	Wed,  2 Apr 2025 16:00:46 +0000 (UTC)
Date: Wed, 2 Apr 2025 12:01:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Ahern <dsahern@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima
 <kuniyu@amazon.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com,
 yonghong.song@linux.dev
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
Message-ID: <20250402120149.4ca403b1@gandalf.local.home>
In-Reply-To: <102dfbdc-4626-4a9c-ab8a-c8ce015a1f36@kernel.org>
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
	<CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
	<559f3da9-4b3d-41c2-bf44-18329f76e937@kernel.org>
	<20250226-cunning-innocent-degu-d6c2fe@leitao>
	<7e148fd2-b4b7-49a1-958f-4b0838571245@kernel.org>
	<20250226-daft-inchworm-of-love-3a98c2@leitao>
	<CANn89iKwO6yiBS_AtcR-ymBaA83uLh8sCh6znWE__+a-tC=qhQ@mail.gmail.com>
	<70168c8f-bf52-4279-b4c4-be64527aa1ac@kernel.org>
	<Z+00OTntj9ALlxuj@gmail.com>
	<102dfbdc-4626-4a9c-ab8a-c8ce015a1f36@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 08:11:03 -0600
David Ahern <dsahern@kernel.org> wrote:

> How about passing in the sk reference here; not needed for trace
> entries, but makes it directly accessible for bpf programs.

Not to mention event probes (dynamic trace events that can be attached to
existing events and the fields can be dereferenced). One day I'll add
documentation about event probes as they have been in the kernel since 5.15! :-p

-- Steve

