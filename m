Return-Path: <netdev+bounces-218418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08968B3C5BA
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 01:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5851C23382
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 23:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B431326AAAB;
	Fri, 29 Aug 2025 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kW4kGuYo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD1F481B1;
	Fri, 29 Aug 2025 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511540; cv=none; b=ciXa6/h3yyuqv76seOvu+4+u0uyL5x7XGcoMzAcEgUSoknmQwt1F9t1hIUzw9PN5U52DUJKzmNrNe0vANt5/tBQtLBnfJD2Jae4/brchNjlmbjAJUmbp6C2mUIYj9N1oy8MpA/n+0H2uIYXIflVWpc+x45yCamYeg/QwfwbDu1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511540; c=relaxed/simple;
	bh=XsieVmqmQDvRN9vdixJwTt7y3JObFV0iHl2hgcNqcAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/fI0AygTtXXeh2jdJwLxgn/e9xp4PD5Y35RXHEO/EGSYRtPB/C68NwdWdhcP2/LxpZX3D5rSFiN1TfjkytzfD0q0zGgER+0zIc21lvLZlEELHWeLhCg7in90WDy7x+KWW6ymHru6wuqThXV+cmm1/qcJxJU39rAp31SRL7uhEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kW4kGuYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922F7C4CEF0;
	Fri, 29 Aug 2025 23:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756511540;
	bh=XsieVmqmQDvRN9vdixJwTt7y3JObFV0iHl2hgcNqcAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kW4kGuYo0dSLgLO7/CySu3T3c6v66TQyZVfXE85bsi4Tva8WXZ5XBjPG2ODsrRErf
	 VlhjOZbQf8UWHGpGpdpvplamj4bDtVkX4MQvvMWfvhch1mvRSFOLkX7AxtDuIg+sg7
	 hA2EjBtIVbTxep1Fmi0QwOTEEqHZJe7jWcQJu0u3piGzmc/wtc/3QYw/C62YtgbIj5
	 U8HlrFSGvFQ0b9vKuBSu4JDQex5q8vLImnaQx9ji6t7CtyFFJPCdYqeGHcAUv7lch7
	 muBCIuu+V/YJW1BjelmaGEO63L93rwVzgNe8PwIy6/ZymPYufecmYBaKaK6iO6gVVm
	 BZgPStMDboE3A==
Date: Fri, 29 Aug 2025 16:52:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Schmidt
 <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v3 3/5] dpll: zl3073x: Add firmware loading
 functionality
Message-ID: <20250829165218.4d597b8b@kernel.org>
In-Reply-To: <94247dbc-4be8-4464-ad3e-5b81bba5f70b@redhat.com>
References: <20250813174408.1146717-1-ivecera@redhat.com>
	<20250813174408.1146717-4-ivecera@redhat.com>
	<20250818192203.364c73b1@kernel.org>
	<94247dbc-4be8-4464-ad3e-5b81bba5f70b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 12:39:30 +0200 Ivan Vecera wrote:
> >> +	strscpy(buf, *psrc, min(sizeof(buf), *psize));
> >> +	rc = sscanf(buf, "%15s %u %n", name, &count, &pos);
> >> +	if (!rc) {
> >> +		/* No more data */
> >> +		return 0;
> >> +	} else if (rc == 1) {
> >> +		ZL3073X_FW_ERR_MSG(zldev, extack, "invalid component size");
> >> +		return -EINVAL;
> >> +	}
> >> +	*psrc += pos;
> >> +	*psize -= pos;  
> > 
> > what if pos > *psize ? I think the parsing needs more care.  
> 
> This should not happen. strscpy copies min(32, *psize) from the source
> to buf and sscanf parses buf and fills pos by index from the buf.
> The pos cannot be greater than *psize...or did I miss something?

Glancing at it now, I think I was concerned that *psize will go
negative / wrap. So potentially leading to over-read of psrc,
rather than overflow of buf. But I could well be wrong..

