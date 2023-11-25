Return-Path: <netdev+bounces-51064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E36B7F8DA0
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 20:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A63F1C20AA4
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 19:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF0928E03;
	Sat, 25 Nov 2023 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="A+pqDO9I"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A289F1;
	Sat, 25 Nov 2023 11:06:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1700939208; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=c0iqwX+9WViNTos0ONMkw6hHVD+swHKuJ/MY6sfol262oHkMJrJIygLv/0RkXXYxRCd7hSP7L5visPq8OqssdcgWzmrY5QyHqny2WbaqPR1KRrGdgq/jb5nELBqWWXO/Yy24Uxk+/ui32anWPUlenesR2LvYayT0XxTEiodB72I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1700939208; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Kjy5h53YNBfRPMZkuD1hYHLFz0/HrabUBTJReH2mQpU=; 
	b=OfrrSf+rGqoog5SYAmftgjqrj5LVItOTkrjCeqNlRwf7az+brvTi8bmFJUUYFTSn6Rb1EqGAV4RJ5m+8MtCmTRO8XgSVZZXVLMmf1CZR6tAzFnEcHSzORgo6za/+Cff0cVTkMFdrf75MaZ04udv0LdN3bcUcwPNfZIyomkfHHs4=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1700939208;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Kjy5h53YNBfRPMZkuD1hYHLFz0/HrabUBTJReH2mQpU=;
	b=A+pqDO9IlsZ3IL+KhevF+swP+v+nT0vypBKBWC8lym/VPxLIl2IpAoS1QC0bmkPX
	PcoR/evOPiy+i/2mcQLwIJoRxb4Xx4niDfLfG64rI9CDswn1tgX3+Mi4tIq4XZ4ARc7
	BPVKf9CmfAofcMlesV9G/JTcIrEWtsvxL23L/PKo=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 170093917663875.992804182481; Sun, 26 Nov 2023 00:36:16 +0530 (IST)
Date: Sun, 26 Nov 2023 00:36:16 +0530
From: Siddh Raman Pant <code@siddh.me>
To: "syzbot" <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
	"netdev" <netdev@vger.kernel.org>,
	"syzkaller-bugs" <syzkaller-bugs@googlegroups.com>
Message-ID: <18c07e01a4c.220c832d175971.1254981088507972317@siddh.me>
In-Reply-To: <000000000000ee78fb060afe9767@google.com>
References: <000000000000ee78fb060afe9767@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in
 nfc_alloc_send_skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Test final changes

#syz test https://github.com/siddhpant/linux.git lock

