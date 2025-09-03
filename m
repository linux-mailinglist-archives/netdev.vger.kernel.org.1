Return-Path: <netdev+bounces-219555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1D5B41EB6
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09E43B19BB
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0D02E8B8E;
	Wed,  3 Sep 2025 12:18:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE412DE70B;
	Wed,  3 Sep 2025 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901920; cv=none; b=mm8YAyAmsowBBK6DXHSPIjXjxSnGlq6IrI8Yh2mZstIcL8/JrfQpzPJvvjPg/ruFWvtSUnzXkVblmfqBMtl/I3O50189WWjuh9KHyr+QY02N6ypUYAWtT0eojpcGLNZqpotbfKASBlUhkmIpNg1MlfCewaZqJhHDtzBFNdM+Vlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901920; c=relaxed/simple;
	bh=lstEIi9WzpFVWj8fTyXdesnCysrrJf6bUtiAjkAEAFE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xr2KDj8i+vtyOxV9H2VK05bliCydhGkuW9NImxTXGuUr1ydviqaa+GQRotcbPZ8qBlK6Y4fbNWBXDGQ3wmovYXMkBQ4bxL2UXZF3Y9868AdQr+AG3ScuigFmoAdeYfVDPkE+USAQTQupyqATBcCfdUtgUSTZTh60djFLTpETJF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201602.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202509032018197334;
        Wed, 03 Sep 2025 20:18:19 +0800
Received: from localhost.localdomain.com (10.94.10.238) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.57; Wed, 3 Sep 2025 20:18:24 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: <markus.elfring@web.de>
CC: <andrew+netdev@lunn.ch>, <antonio@openvpn.net>, <chuguangqing@inspur.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <sd@queasysnail.net>
Subject: Re: [PATCH v2 1/1] ovpn: use kmalloc_array() for array space allocation
Date: Wed, 3 Sep 2025 20:17:09 +0800
Message-ID: <20250903121710.69026-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <91b13729-7b5c-48a2-acb0-9f23822dcf3a@web.de>
References: <91b13729-7b5c-48a2-acb0-9f23822dcf3a@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
tUid: 20259032018191084c6a5afc5bd575dc14418cfe7c3dd
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Hi Markus，
	First of all, thank you for your reminder. According to your suggestion, the format "Chu Guangqing" should be used. However, in line with our company's signature conventions and my previous contributions to the kernel community, I have been using "chuguangqing". Therefore, I have to continue using this signature. The signature should not be changed frequently.

> 
> > Signed-off-by: chuguangqing <chuguangqing@inspur.com>
> 
> Would the personal name usually deviate a bit from the email identifier
> according to the Developer's Certificate of Origin?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Docume
> ntation/process/submitting-patches.rst?h=v6.17-rc4#n436
> 
> Regards,
> Markus

Best regards,
Chu Guangqing
<chuguangqing@inspur.com>


