Return-Path: <netdev+bounces-279094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aELbGv8V4WnoogAAu9opvQ
	(envelope-from <netdev+bounces-279094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:01:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBB04123FF
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCDEF3018AE5
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 16:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472F530E0CC;
	Thu, 16 Apr 2026 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAR8HE+m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA1F276049;
	Thu, 16 Apr 2026 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776358727; cv=none; b=B8L9njTVGBM4tu9Ikj4CL2r45AaJN6qAxrmo+xS0Y5RgHmKqEIVDoWtEQuTlN/2OS9Tia4nT9JZ/8vTDJegR9yn470WNtRGcbRa1cFIQ9ppbmDYrs6C4dHWuq1TUPtyvXZquSRpPDYYRzdoe2Ih2PCm6G4cfzl0cwzRAqNilaAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776358727; c=relaxed/simple;
	bh=5UTE5Zfchr5aKLFBqrb6zXmfHVkoF5Y2ojYgnnVHrWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZtPjk+buqRQMjI8ItbU0J2NWrCuGbBAFbND7s1BwuvTdPx9aLhR7pMIm/27dikZSvedfUwFGPrzEdo/fOH9uNJhLMP82mYFXAV4RUonXRNuvYe66jp2GKf076Z12jSGNioymtWnafbr60w2DJ9MLEgZur8p6meJoasee0IpD/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAR8HE+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51C1C2BCAF;
	Thu, 16 Apr 2026 16:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776358726;
	bh=5UTE5Zfchr5aKLFBqrb6zXmfHVkoF5Y2ojYgnnVHrWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vAR8HE+mtAkJx79kw/58zn5xcXgJTPkrl+L7CAdjjeebUdinIrp/KYQxQWb0rk0Y+
	 UcWJ8GgR+c17sO5alWCdR68VQRxGu1O0ufT7rC1GDXt7gX/jzLqJKCDxZ+BOUUHjGz
	 fVkcon7hTnPXQd6mkvOfW0W42bwuxR0QwFQhBA1JWYDoIOsVq78XwLzd8wYl38FLBW
	 jSbX2CJ7R4MiDksjT/Oj0p/OpP7osyh3zde8ag+KF7+icbA7jI44OAIJbtIwwDR2TV
	 GNr0S2316bSbwoqKDt4EJG+Wap8Yh2g5XeXwg26pXMwF1eekHqWQEePTRLzwTuIAK+
	 1a0dArdM1KI5w==
Date: Thu, 16 Apr 2026 09:58:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: linux-hams@vger.kernel.org
Cc: Chris Maness <christopher.maness@gmail.com>, hugh@blemings.id.au, Greg
 KH <gregkh@linuxfoundation.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 stable@kernel.org, workflows@vger.kernel.org, yizhe@darknavy.com, f6bvp
 <bernard.f6bvp@gmail.com>, Jean-Paul Roubelat <jpr@f6fbb.org>, Joerg Reuter
 <jreuter@yaina.de>, Andreas Koensgen <ajk@comnets.uni-bremen.de>, Thomas
 Sailer <t.sailer@alumni.ethz.ch>
Subject: Re: [PATCH net] netrom: do some basic forms of validation on
 incoming frames
Message-ID: <20260416095844.12f628fa@kernel.org>
In-Reply-To: <CANnsUMFVg9nZnJ_He38O9Ui1YUM_Je7MGO-y_J+oW=TG3jV1bA@mail.gmail.com>
References: <20260410145448.38253e3c@kernel.org>
	<20260410221220.1708137-1-kuniyu@google.com>
	<4f5810a7-c792-4d6b-9f7c-6c6b289def19@blemings.org>
	<2026041135-shindig-trekker-5d06@gregkh>
	<b9355e3c-9252-4dd7-b7ed-dff13e3b2c8b@blemings.org>
	<2026041124-hyphen-circulate-34ae@gregkh>
	<3cd91fbc-d3a9-431e-b915-58e851c7df9f@blemings.org>
	<CANnsUMFVg9nZnJ_He38O9Ui1YUM_Je7MGO-y_J+oW=TG3jV1bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279094-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,blemings.id.au,linuxfoundation.org,google.com,davemloft.net,kernel.org,vger.kernel.org,redhat.com,darknavy.com,f6fbb.org,yaina.de,comnets.uni-bremen.de,alumni.ethz.ch];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BDBB04123FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 12 Apr 2026 05:56:50 -0700 Chris Maness wrote:
> Thanks for your work, Hugh.

Hi good folks of hamradio.

There was a blip of activity after this thread started but now core
networking maintainers are back to reviewing all the fixes themselves
again.

We would like y'all to set up a git tree so that you can handle all the
incoming AI patches, and send them out as a pull request. This is how
wifi, bluetooth etc. operate. You already have a mailing list so that's
good.

We do not have the capacity to review all the AI generated fixes, and
ignoring security fixes does not feel like an option. I'm planning to
send a PR early next week, shedding some low usage / high CVE count code
I hope you can have the tree in place by then.

