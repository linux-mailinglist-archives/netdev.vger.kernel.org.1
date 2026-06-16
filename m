Return-Path: <netdev+bounces-299751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LYTmK8jsMGooYwUAu9opvQ
	(envelope-from <netdev+bounces-299751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:27:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0138968C81F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:27:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="nazHv/Ia";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299751-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299751-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CEE73025914
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8BA3DB312;
	Tue, 16 Jun 2026 06:26:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980E83DA7C2
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 06:26:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591219; cv=none; b=Bp5H3huQB5C3BBdrQm/3A9ZBlWe6ths6saFBG2EYRGHU1xpQUxxZi6DKyMD4MjSocyhxJVjDQ4VTUVqsi5qCK3FbjyP8SQYUd+tFzoiMOP839ErPc7TpAksQsAF7lymSvpE4k4Vjfd1FDXLVX6GI8rz8fS+RhETa0AzaZMqLDz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591219; c=relaxed/simple;
	bh=iRry9oHclMRfUqD5tUtX/k3q8ux6WR0QhAjkaVxOinM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYC0iXc1hg3G1ieWsLEE5+sMsqr2hFtcwjOcmz/aziXyNjm+Y38jnMuS8BD/87TPOrmzI05OaG1IxGFG3AlXlTgavBawrzT5/VKbEcDn2RfFXZMxb7yNT0s9jQHioDjSePM86UC4cL+4fFnNOMUNRhEzmBqksRNp58amtfSFZTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nazHv/Ia; arc=none smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-842d37438d8so1617953b3a.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 23:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781591218; x=1782196018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rI93y5seViHg5YidVC1YNQsLofTGTFtrXXZXnF5WUWU=;
        b=nazHv/IaA02hVO+ICRnyNUUUi64Ub3uWOzFJP5EHOR4O0rP3Ig2N3pRDS5yQD2afE3
         O8ZBdEm3ioT0gzxUQVnvrOUNbh82y5/p/13Zx7jAA/pLA0sU6q8C9WIfxzGR1pCWiQX1
         wL2ZzZ8AftfzX+bp4/T8E+jLSF+PrFyNxsE6wQkyR4OACbhG1EVSEMxJe5xfTyxxWyOO
         +v1Y4P/3cxOmhNyxWch6Ntl2hyLMJ1bJ7spRXc7d8ffkiz2/K/u7rFQBCor+/5//eLMg
         W4GsgK6zdcdC20eJUp8yUPNj0VGsSeqlbM8l4XdMvFDAFXs04XKQJ8rhjbTaEarmge2G
         OwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781591218; x=1782196018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rI93y5seViHg5YidVC1YNQsLofTGTFtrXXZXnF5WUWU=;
        b=XQMg8aYUm1N0zIuUdAlrZlTR2v5nRD0ZNOoAeyyVROdjtXm802BDkifUBPJ9h9vW8P
         +ytlRZzKdavwpXHHMBUGn4ogXYTlZwUgiv7+SCq94R9fT5suXkNLGN0VYw0+745SD4k2
         oSRiYA/aGqkXTgo2iYBMd2ELKJw2RcOx/cVrrm/23pm70zJjY7baz5re6B+s+nWtLCST
         NASiL9LJH6gPlX7iT48GzD8HYhUTj6czGdIZ30rLXcbF4kq8fS7Dvdvsqa6OUawrbDVF
         IyMZT0PjpXfYkiwKYP2roGgNTZ9DqK/o5OZXBrEbgrDdlcpvQmAC5Hjj+kPpwpcCbG+S
         xVVw==
X-Gm-Message-State: AOJu0YwB9rgqMoGgWhIbzZ9YoRoDf+syFiQ1/uBw9ft3r5cQr2rWVjbS
	eHPljcoUQd2bQY4J7GssHSMTSJzWhTSbxJ+/ysbYpE+FzPX/1KuYXfL8
X-Gm-Gg: Acq92OH2/3P8j9gXA4htZAsyK25i1JHyU3BijMCZ2ZVbMdGLxCaOO8RZ/4o+6O68VHX
	xBfOldMPSQCQjdnargy93zQytAWI1R9NVAPLLrZlBlqy4U9Jx8sR0KsNwazw1X6v86lfkigWw04
	BaeK4rUm+0OEM1nb9ZE8c7NFg4ulUETfzC6kbQEaFIfEm6fKyb2We4wm5z42RvTZuO1RVcOFyuP
	hik0qNQ65vVxs/2iB/FOkMAbxxZsnT7CLDMS/Mnh6/ZsGZmGhoUAnTeyk+a6uCRAabq9BdI0mPA
	+r4S0AM24/EKFp245f9zvVKSj+Qkk1TiepcbR+vEgzNHKLV9s12DAMwbn+yxKuAzSxBH224Zuc2
	v3xErVJ7FO/VesQXOsLMC6LOT8Fo2J0fjqybBVOIlZWVRTSo9r84hzIMBwLtrxZp8rNHwcQcuZr
	7+puevIIGAyldYo1lMQZCu310wragZmXbZYx0X7/ntB2Xd8r6CIo39GiY9qyhbdHAZhXHenx8=
X-Received: by 2002:a05:6a00:4485:b0:842:2f3d:dff2 with SMTP id d2e1a72fcca58-84515521648mr2243020b3a.34.1781591218063;
        Mon, 15 Jun 2026 23:26:58 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b009e67sm14154810b3a.42.2026.06.15.23.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 23:26:57 -0700 (PDT)
Date: Tue, 16 Jun 2026 11:56:52 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Yeswanth Krishna <yeswanth@linux.ibm.com>
Cc: netdev@vger.kernel.org, venkat88@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [BUG] kernel BUG in team driver: buffer overflow in
 team_add_slave()
Message-ID: <ajDshKtFNpQAtHQ0@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <3ad19e86-234c-408f-896e-0d6c774fea49@linux.ibm.com>
 <a08b0a7f-089f-4428-9360-9edbec3a5453@linux.ibm.com>
 <ad80ee33-400b-4c63-8197-838c3cf85cef@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad80ee33-400b-4c63-8197-838c3cf85cef@linux.ibm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299751-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yeswanth@linux.ibm.com,m:netdev@vger.kernel.org,m:venkat88@linux.ibm.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[mkchauras@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkchauras@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0138968C81F

On Tue, Jun 16, 2026 at 11:38:37AM +0530, Yeswanth Krishna wrote:
> 
> > Please add below reported-by tag:
> > Reported-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>\
> > 
> > 
I am also not able to reproduce it.
Can you paste the full report of the crash?

Regards,
Mukesh

