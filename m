Return-Path: <netdev+bounces-275703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JKhOHX902kSpAcAu9opvQ
	(envelope-from <netdev+bounces-275703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:37:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8923A64A5
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3894300BE21
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675EA3939AB;
	Mon,  6 Apr 2026 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="LJbR9dh4"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A34738E5F6;
	Mon,  6 Apr 2026 18:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775500653; cv=none; b=DE1AaXlDxojc0/61yPB4NNpz0/MZ6aBfgCSZJmNCCFh/R0zTFH234TOA2a0zfHoJhtkQIjHHsCbfms7LgCOS3Bhc22qeQ+RJOvsD23T3LMj2LLLVpLsBYJ/ekIeIcd5SW+A4wvFd5nCbQbPrxttdDVtTih6OLtS+9LdqfmUwrS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775500653; c=relaxed/simple;
	bh=j/OcC1PBra97L2e12u5xT99c37IGn8k7+8n/kXD/Ng4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=P0+of/ddnYkoxVsKW29KzpO/yG1MnFyqDAgzpnNkY2Np7+liMldFffZ2tJIjEbmbmvTXQa2981voPMOb5C0/IYj52d2ajURQ2b2pgsGq66AJXveemjp/UC1NcDJaZSEm6+bbJpjvksGrz+2NO3PymnlPta5ZCOxJmcbkwDw4aeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=LJbR9dh4; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C9251A5888;
	Mon,  6 Apr 2026 20:37:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775500648; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kff7k9sb1vSdk8ThNR1w5zwCc9/cSFpnvvMQ/mvFjKk=;
	b=LJbR9dh48Z28a7oODi05q5LCn0xvjV5bB1c6ERpYX9n35JsfdDJfSJk/4TELdcnu4VEycF
	uEWo0GmcIFxAkKGksNk+GX88jGceHzi22qrRnIZUeZRr4jKlRjv+b2maiyRvebbhDqHt2F
	F5Dn5pszA1Vy1qttnNgMlxZIFxGyzTx1FUv4isAfogspYLALaxO5/mIGty4SJPPjOtgYuk
	Zi//dWqmAGTWwJ936oLzf/ne6+fMbCH2xOfJNNstClp5uAzjTGfOxVtmEbHsRdoV6YjI7e
	12e4evHsIEK3ugFY8dBNB2PW5SEL1oNTQnoCKa/DYNembxt6pGu2/DGTqmeZ7Q==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 06 Apr 2026 20:37:27 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] docs: netdev: improve wording of reviewer
 guidance
In-Reply-To: <20260406175334.3153451-1-kuba@kernel.org>
References: <20260406175334.3153451-1-kuba@kernel.org>
Message-ID: <04de66f8f3d92720fcae6280b70f57f9@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275703-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,lwn.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED8923A64A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 6.4.2026 19:53, Jakub Kicinski wrote:
> Reword the reviewer guidance based on behavior we see on the list.
> Steer folks:
>  - towards sending tags
>  - away from process issues.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: corbet@lwn.net
> CC: skhan@linuxfoundation.org
> CC: workflows@vger.kernel.org
> CC: linux-doc@vger.kernel.org
> ---
>  Documentation/process/maintainer-netdev.rst | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/process/maintainer-netdev.rst 
> b/Documentation/process/maintainer-netdev.rst
> index 3aa13bc2405d..bda93b459a05 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -551,10 +551,12 @@ helpful tips please see 
> :ref:`development_advancedtopics_reviews`.
> 
>  It's safe to assume that netdev maintainers know the community and the 
> level
>  of expertise of the reviewers. The reviewers should not be concerned 
> about
> -their comments impeding or derailing the patch flow.
> +their comments impeding or derailing the patch flow. A Reviewed-by tag
> +is understood to mean "I have reviewed this code to the best of my 
> ability"
> +rather than "I can attest this code is correct".
> 

I had the same hesitation when starting to review on netdev, unsure if 
my R-b
carried any value. Therefore I appreciate the addition.

> -Less experienced reviewers are highly encouraged to do more in-depth
> -review of submissions and not focus exclusively on trivial or 
> subjective
> +Reviewers are highly encouraged to do more in-depth review of 
> submissions
> +and not focus exclusively on process issues, trivial or subjective
>  matters like code formatting, tags etc.
> 
>  Testimonials / feedback

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

