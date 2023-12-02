Return-Path: <netdev+bounces-53255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E12C9801D2F
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 15:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B9C1F210FC
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 14:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81EA1865D;
	Sat,  2 Dec 2023 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="OPV+rVKz"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B1311C;
	Sat,  2 Dec 2023 06:12:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701526329; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=co8hkZZFiaUijqDwUXVAnba0UTOchAS1ZCo1E+u0JgS2NN0kdLyzd0h0iSc4AY+4kxxbcOJFI86/H0iROftCuPNsqI8Wn3IiCXNKHdRoTXfretuIgTjKTENmkyw3a6TnBl8cVXZml1nLDRFHAqIChOIxLNciU3kgWVtVC1EWIyE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1701526329; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vsqkAH0yBJeH0U/+V5ZEHt7TaF6k3M78Pb7xpgVsqEc=; 
	b=VJ9Uzjbb4koo2V8N9b9yOQtP57Bs0zG6k3H7AIIaygavMNFyvgxKdnOxysQGFErweacLN/b3ah6jM1qnJZWOOWsZPNcbAj2b1ZgojOaidI8vyhhh8cE6L3Hvwd8my0U7xtSshIa0W43xAcmtXi3Diyaypk0LDdYt7VOOxvH4s+k=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701526329;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vsqkAH0yBJeH0U/+V5ZEHt7TaF6k3M78Pb7xpgVsqEc=;
	b=OPV+rVKzM7GRhVfBhdlrYFcwYl8rayZlm4KH6tMnKhz/v0NnOJusN9kbEKdJ5RKp
	CYhjQ5DlR7eSEJr2VGGsL5fpxOiw6Ic6WeKX8f66Ti02XdY31/+i50gURIehCnfU9Iy
	ZiWcazx/ADlmp0/rDDQ2x6jIC9UO0/wuLXzx0pdk=
Received: from [192.168.1.12] (122.170.35.155 [122.170.35.155]) by mx.zoho.in
	with SMTPS id 1701526327621523.3303507041147; Sat, 2 Dec 2023 19:42:07 +0530 (IST)
Message-ID: <b4bc6554-6870-43fe-87df-1a2f947e6408@siddh.me>
Date: Sat, 2 Dec 2023 19:42:05 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <000000000000cb112e0609b419d3@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in
 nfc_alloc_send_skb
Content-Language: en-US, en-GB, hi-IN
From: Siddh Raman Pant <code@siddh.me>
In-Reply-To: <000000000000cb112e0609b419d3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Test repro on main.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main

