Return-Path: <netdev+bounces-182056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F90A87963
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 09:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDDAD3A454E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 07:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACA81EBFED;
	Mon, 14 Apr 2025 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="xNUoGgeq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B5E1ACECD
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744617005; cv=none; b=avluPVaQn7ZRW2ljISJ9ZYNXiJWE1HTcFXneRMeCusGrq9r8JpeY2JGvArefxuubdiBiphjmOIv68sDmVBX3cWUhMqIUGS3e0EuhzmV7Xq9xVH/KwrQs/lELcxqH7oFBNI/hvYix+0qOt+pBnzQdFPBx6H71CQp76icElV1cpfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744617005; c=relaxed/simple;
	bh=NIbRUZnU4G0XFYB6n8LPOOozf+RCA90cY7Wfu29msrc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HPW7OPWA+AL3fKK69JfdQpIRoy/7lwSxooNTd+Z6dB2TBO/8qSCutTkpX9SQeaQThZZXtZM8qFE4oWOXOI08l/N3hK9qPsST193m1AJVnlJxYr5E07pLMhm6DO69XT+f30Wu+IaNE65EQx9X19xhtnuUkUgNW8wxrLOldlHB2Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=xNUoGgeq; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1744616988; x=1744876188;
	bh=NIbRUZnU4G0XFYB6n8LPOOozf+RCA90cY7Wfu29msrc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=xNUoGgeqMBYeVqnPE+ARJJ4c7Dqrkp2aFyrFTrqd0Tq6kfD5kA4RDY9xJiT/bl2+1
	 WTiK4jdEQWxhgmcwsWHYASlhVMFE3sGoE5uRWgQqHx6/qM7ORrOCv8ZalR1I0lm9Ai
	 FZM4HikbSWqIMBhHfL8R0wIzZQCjNCPJhO70oKgLi771FJ5zMfMhgCOTiZ2NSXJ+o6
	 InHDJ2P4GHCyjYDwjGznr9XTorhlXKadPTSrB5LXMOsC8S9LSeyZ67/c4jn8W6DCYH
	 s6i6+fIiEEYMFSCjwTks5dqH/iPazx7taem5GcDEkNEkhb63jm6rDYtinI055vTORM
	 ziKAW2pQjA/zA==
Date: Mon, 14 Apr 2025 07:49:42 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: [36 PHOTOS] I have SUCCESSFULLY installed Check Point Firewall R81.20
Message-ID: <syWm7JjX3plfAqaf_E9Cizrg-Tw3CRq0dnxcs3r_8tZ-I704mQkEbTyhWMMs-xLTMrUiLgElXd1IyfoETUsKXbkjUGVxjUqr0piIImph9X8=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 9511f04200fe8ca5a220f017db6945c77c445ab7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: [36 PHOTOS] I have SUCCESSFULLY installed Check Point Firewall R81=
.20

Good day from Singapore,

Check Point Firewall R81.20 has Linux Kernel 3.10.0-1160.15.2cpx86_64. Chec=
k Point Firewall is based on Linux.

I have SUCCESSFULLY installed Check Point Firewall R81.20 today 14 April 20=
25 Monday on a bare metal physical machine.

I spent almost 1 hour installing Check Point Firewall R81.20, from 11.32 AM=
 to 12.31 PM, Singapore Time.

Hardware specifications of my bare metal physical machine
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

Processor: AMD Athlon 3000G
GPU: Radeon Vega Graphics
Motherboard: ASUS PRIME A320M-K
RAM: 12 GB DDR4-2666 MHz
Harddisk: 1 TB TOSHIBA HDWD110
Network interface cards (NICs): 3 (eth0, eth1, eth2)
*I will probably need to add one more network card.

36 photos (with timestamps) were taken using my vivo V25 Pro 5G Android pho=
ne during the installation.

I have compiled all the 36 photos into a single PDF document for your easy =
reading.

Below are the redundant download links for my PDF document:

[1] https://drive.google.com/file/d/1QqWRa2t-Nore2rqWfxcaUJZhpsIqzT5D/view?=
usp=3Dsharing

[2] https://drive.google.com/file/d/1t_9HikI1kmjhNEiF2LS2nM76jRbHNrCA/view?=
usp=3Dsharing

[3] https://www.scribd.com/document/849678265/Photos-Installing-Check-Point=
-Firewall-R81-20

Although I have SUCCESSFULLY installed Check Point Firewall R81.20 on my AM=
D Athlon 3000G physical machine, I have not started to learn how to configu=
re it yet.

I will spend the next few weeks or next few months learning how to configur=
e Check Point Firewall R81.20.

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Singapore
14 Apr 2025 Monday 3.46 PM






