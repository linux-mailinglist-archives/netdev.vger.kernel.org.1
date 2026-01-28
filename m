Return-Path: <netdev+bounces-254242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mF8wMoIDemlE1gEAu9opvQ
	(envelope-from <netdev+bounces-254242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:39:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDECA15B3
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 141E83034E2D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E2734F465;
	Wed, 28 Jan 2026 12:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECP9Uwd9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DA734EF1E
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603778; cv=pass; b=gJPl7Mf2Ggs/ON5UpngmKHczfdWkscs8eQ4sxcRyA8Yb5AU3gqDL2c8Je7qEbyMFYetWmoe32wtmirZW2yAQZkv27GLDdaEB+xZvCMsxrorS1LqJKndvQhER3HcUODOuud2NFuQaVI+r4lDboNT0lBONg0r7phY2EnY+rY1MjKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603778; c=relaxed/simple;
	bh=0m5E8IA1paqB7ISR5kKm0HGcgn7kq/aAqBYoPMGhVig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DED4mP8dGvHjaMM7DMUOEYM/Mcuy34NYIAjmZNEYvoA3VlHbhtC519XzvY52p3wVPk9FoZIm5szOw5dldBE1YCj71nzOe90Yw1jqYGC0Iu8QffX52HeOdDkWYDG/LOX7thaUc0U7NARpEx0F6vgvrLlmj1EX+tVEmcyQzaLdQP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECP9Uwd9; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43246af170aso582825f8f.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 04:36:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769603775; cv=none;
        d=google.com; s=arc-20240605;
        b=devPHxlElxnlzhoLlm1Pfs5RG67tbPWSiDDGmfr03ggjSPFYszlwsWwrytf5HXm/VH
         lIT1uEV+oG0uD1zIpHTJ3vs0qW6kSd7cijOBUy6hLklg50pC5PvXO7l8BQd1Jb6y/is8
         X4jVdw6KABzghntjG5qoX03Ikn8MJblJmU0W8CaJLU32PJXPxGnBZCU8uyNdJAnKgZkm
         YjIpXRPTQpVcWaXYe2U6GhJg6ZbgbuHvdS2BJnFaL+xwxPrnwm/gagg7c1uMz/VWPTwA
         6GfTmxiS4clcrzseCtf8PsHlr6C0f0wWZ2V+buCBsJfU9Mt6aSIgzpmLALlLiNayfiQ3
         b0Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=crs0Vju6vr7yYnAWVTgMbD9mwNnywM1py8zBU7RR7yQ=;
        fh=AZQs93mumlq/NH09SLFEfiu63PPOd5RXOp1OtF1pTxY=;
        b=QuviB7o7ZpCgWgA1QuOoH2YJzx3STaijpLogXMQFpy/4mcoettqTPL/HcBosBiQlp6
         E6VJ4WLvkE3DgpZdWJuxLJB1rA/8LXlc8jecIhAwnJ/FR6QWZl1EXEQ6aYuPm75d17Pp
         pCJppjb0olqt9IDlyeQXxjv8Ph6GQJjzpGy7p4KffEhqSW0y19nEUMbwEaIc+5O9td4J
         iCV3ea2+7/5Dfq37vW0ULzqw5FBKD+XLjls96l92csmNKthTnvh4cGViYcpn5j0eb4RO
         YCyPirMFzdVKJdsKOLva8+M8aUbOyGYk6u+LUTN9OTBwe1oZMZ5pFJybwOPmCJBD6p4O
         9rSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769603775; x=1770208575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crs0Vju6vr7yYnAWVTgMbD9mwNnywM1py8zBU7RR7yQ=;
        b=ECP9Uwd9ruxwdmiZXEX+cN49YgWATHnbSG4fx9LESqIrs5r3zrfX5HYrBeFtiL6oqG
         4Hoegcuo5/FE3qET60UFU4/tU/qC+fV8b3D9nX7n85zSQTU8oaE/5oMjyoIOQI8j1hrS
         9DWj/rHqFyfnyWqUa6FPtvJHsSnT4dpui2GHGeo7sk00FJ80Ke7I4NhixMJQ482gcIO2
         kiYoiurWyU2ErMSVCv0tahB6EsM9LlqWopBPhJOnZZjwkj67o3EUXK5puSjmxP1VxdcG
         tdyWrAkSMaxlsnq5+/+zoXl7r0/ISSUOF1eOVkIKGtGuRFhqSnf8C6mCm/jSnLkdCqPV
         Kknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769603775; x=1770208575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=crs0Vju6vr7yYnAWVTgMbD9mwNnywM1py8zBU7RR7yQ=;
        b=wEmAp3bbLJ9dRP2XV1utlvfs28qZpyeDtp6lX4dh0a+I2CQa/+NnMzPk0Cag1gJZjz
         N3qH2vFICWHxJtSFbGNn//swZM4ottn+6kQMAsPM22LjrgS0JC/VKnAt3o3UCzNdGYjO
         dgs8DjyozvFRUWATAje6OApDfvgLh1P/lEOVluJDOO0g3rDFXztFBv6gf6DSGz9POQlU
         MqReYrs0/mx58TGAqkohX7QdwWTC8GayoqepxhJXLADosX2gMZjOozVVSJCO3AkqWi5m
         4NUo1vyrgSWfr210DWldexVz4WQSQPZ9GBqqr87SdI5yIn1cuE8+Z5oG9h53v9qD834e
         T7ug==
X-Forwarded-Encrypted: i=1; AJvYcCW6GxiUQW4pjEa/DF/yJ6L+SSo9k1Fjt739L4SFsDN7Jt7cbYm2ravDE04wKwaXe2ltQh1xAGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWepOd9Qjf+O1RxoCNgLRI9ralGHK0IWdsmLnEpsrO69yPlQrE
	Pnp8Kjvplo4+r2oozqBcN04Orz5ylw82ZDMF3hcqPkconrYLqJOMiIHu/AgflOedEYGeGyE9lq5
	rtiueFlST5e9k/agNP1FCd2coe/v8ruk=
X-Gm-Gg: AZuq6aIQj22oM6cApz+eItmCRbaOEvEp1EytuJqRWXbVCLzzBmHB6REVljR0iCr4eF/
	Y7W/6H93peu4D3jYKMUXLKWovKTJeCS9XYoCiF8wcvnd3NvykfhBPZW9vFzpDrIBUpzK1dPrROU
	T9OvLqFa8SAV6QKkPIrG1BwEm3uqOLW9ERTXTdJUT5KHHw1PK3kiggpIpYxY8Hy8hH+LafvXivW
	L6tV6bhAwrdpifQ97bD5qqtuG6h8opNmHx7XHr+nxyhXX/8dRHA2Nys8vET9b6Bb3Erz1l1SNon
	R71zyNuSLUl2RMHH30ZwQFlTqwqdkCu6AleGxmca
X-Received: by 2002:a05:6000:1acc:b0:435:9538:939b with SMTP id
 ffacd0b85a97d-435dd0bdf07mr7389967f8f.8.1769603774762; Wed, 28 Jan 2026
 04:36:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOf3c5fDit7nvfWUGf+f5Ctmfr9ebg6KqiwZhZYusHyFaeE5CQ@mail.gmail.com>
 <2026012758-dedicate-desecrate-358a@gregkh> <CAOf3c5eJp7432wRk1E0cDTWMccO_m9fWYDKU25-qJ7Owk8mVQA@mail.gmail.com>
 <2026012720-outmatch-worry-b92d@gregkh> <CAOf3c5dCsN2rDURv_Ct_K2agiFRe1zEjrQi1AM8LjTCfUYnLVw@mail.gmail.com>
 <2026012811-sepia-aeration-0238@gregkh>
In-Reply-To: <2026012811-sepia-aeration-0238@gregkh>
From: Ivan <kernvirt@gmail.com>
Date: Wed, 28 Jan 2026 15:36:02 +0300
X-Gm-Features: AZwV_QhV-QUZ03xLcrLR9WYrlRvPQvrZerzkyXKOuy8J1ws6BMYgtD1xwGPsGEM
Message-ID: <CAOf3c5fO33EYtpAY0qOCgJhTKH+MYUB+4CKNR_R1fmEi0cxKEg@mail.gmail.com>
Subject: Re: [BUG] r8152: Tx timeout and xHCI setup device timeout. RTL8153 31.00
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254242-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kernvirt@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linuxfoundation.org:email,wikipedia.org:url,daringfireball.net:url]
X-Rspamd-Queue-Id: 3BDECA15B3
X-Rspamd-Action: no action

=D1=81=D1=80, 28 =D1=8F=D0=BD=D0=B2. 2026=E2=80=AF=D0=B3. =D0=B2 09:11, Gre=
g KH <gregkh@linuxfoundation.org>:
>
>
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
> A: No.
> Q: Should I include quotations after my reply?
>
> http://daringfireball.net/2007/07/on_top
>
> On Tue, Jan 27, 2026 at 07:02:46PM +0300, Ivan wrote:
> > Yes, the log is correct; during the time since boot, I had just
> > finished downloading those 900MB of packages. In this specific case,
> > the interface disappeared just before or during the reboot. After the
> > reboot, the interface did not reappear because the hub remained
> > powered, and a physical reconnect was required to initialize it again.
> > The previous log was short because it contained only kernel messages.
> > This time, I am attaching the full output of journalctl -b for more
> > context.
>
> Thanks, but it looks identical to the previous log, the device, at boot,
> didn't want to talk to the USB host (i.e. your computer), and so
> disconnected itself.  It must have gotten "confused" and so a physical
> disconnect from power fixed it.
>
> That's a lot different from "it was working and then it stopped", so it
> might be a firmware bug in the device?  I don't know, sorry.
>
> If you plug it in, after the system has been booted, does it always work
> properly then?
>
> thanks,
>
> greg k-h

The situation is as follows:
I boot into the OS with a USB hub pre-connected. The system has
internet access, and I start downloading packages. After they are
successfully downloaded, I perform a reboot. In this specific case,
the Ethernet interface disappeared from the system during the reboot.
Out of the 4 crashes I=E2=80=99ve encountered, two occurred during a reboot=
,
and two happened out of nowhere while downloading packages - the
Ethernet interface just dropped, and the download failed accordingly.
ip link shows:
1. lo
3. wlp*
This means the second interface, which is the Ethernet adapter, has
completely disappeared from the system; it is also missing from lsusb.
In the log I attached, I did not disconnect the hub manually - it
simply vanished from the system on its own and did not reappear after
the reboot, as it remained powered and was never turned off during the
restart. To make it appear in the system again, I have to either
reconnect the hub manually or completely power the laptop off and then
on.
I don't know if it's a coincidence or not, but all 4 crashes happened
specifically in tty. As I mentioned before, I cannot catch this crash
in a DE; perhaps it is just a coincidence. I also conducted a 2-hour
test in DE: I received packets from the router over the local network
via iperf using 15 streams at 1 Gbps without any issues. However, in
my log, as you can notice, I caught the crash after only 7 minutes of
downloading packages in the package manager.

thanks

