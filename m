Return-Path: <netdev+bounces-68783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489168483DB
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 06:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94B91F2411D
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 05:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC70101FA;
	Sat,  3 Feb 2024 05:01:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-69.mail.aliyun.com (out28-69.mail.aliyun.com [115.124.28.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578C110958;
	Sat,  3 Feb 2024 05:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706936505; cv=none; b=TdqOk/2l8Vhb7IoX7BzqZsF+GPsVfuJSELrkD1h5PyRAgh0XVtRGLMZJRzBMec3zwPZMVDWsK2hS8BXvs7IOpLveHp5Fbt3Q5oC4ubk6MJuzG3pd1aduPMN1CjGYIUrI2BDMN3IpoGXgVOEw2PVF8rGqdHwN5ojoXdjrxgt1OU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706936505; c=relaxed/simple;
	bh=xqQ9D7hERT/vB7vrVs/3htRauVPt9sTmgzkZogOZJTM=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=IwbDSgANH/pCB8aQYCyK5DNacVjrfAqqdCAaXU1x/jHeO2vPP6jM9/31v6L+ugljPwEn4+6yUyg4bgqWqWMp4AUpIpq+0Fs4tYunWuBlBFD94uha/x2/XRnXzxVAeUV4246JTJdL8OJESJzBXDe8BeSNeGAIMaOL2AjfWUqirK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aibsd.com; spf=pass smtp.mailfrom=aibsd.com; arc=none smtp.client-ip=115.124.28.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aibsd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aibsd.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.3797697|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.102483-0.00432032-0.893197;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=aiden.leong@aibsd.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.WMKQuwr_1706936486;
Received: from 192.168.31.5(mailfrom:aiden.leong@aibsd.com fp:SMTPD_---.WMKQuwr_1706936486)
          by smtp.aliyun-inc.com;
          Sat, 03 Feb 2024 13:01:27 +0800
Message-ID: <c6b8614c-6b6f-404a-a195-422b6ee8e030@aibsd.com>
Date: Sat, 3 Feb 2024 13:01:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: davemarchevsky@fb.com, sdf@google.com
From: Aiden Leong <aiden.leong@aibsd.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 robh@kernel.org, johannes@sipsolutions.net, stephen@networkplumber.org,
 ecree.xilinx@gmail.com, sdf@google.com, f.fainelli@gmail.com, fw@strlen.de,
 linux-doc@vger.kernel.org, razor@blackwall.org, nicolas.dichtel@6wind.com,
 Jakub Kicinski <kuba@kernel.org>
Subject: net: fou: Is FOU/GUE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I worked for a company that tried to adop FOU/GUE(which is basically the 
same thing) with some extra features a few years ago.

The project failed unluckily but I am still willing to contribute to 
this protocol if possible.

I've noticed that GUE is now "Expired Internet-Draft" in IETF, but I 
also noticed that fou.c has been rename

to fou_core.c, fou_bpf.c, fou_nl.c.

ref: https://datatracker.ietf.org/doc/draft-ietf-intarea-gue/


I'd like to know:
Should I contribute to this protocol?

Is FOU/GUE dead?

If I'm allowed to get it involved, can I add advanced features(such as 
FEC forward error correction) beyond the draft(version 9)?


Cheers!

Aiden Leong



