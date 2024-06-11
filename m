Return-Path: <netdev+bounces-102620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0364903FB6
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 17:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E32B288060
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4792C6B7;
	Tue, 11 Jun 2024 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XMaLq7Cm"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25306364AE
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118308; cv=none; b=bTugj51mzA6rogz0z+dhND2zI5BIckTyJGyfb0kZ0ZgNDrWnAM0Pc4X7J2LUkafCmG5IUMLef6YjmQywou0oLIxqoDepXdLLCt0GTAJaqMbJ6lB3mwuwJcmOzrzgwQthHTJyYz0phaQD5/4nIveJ+zsODswyYLX+u92aSaasun0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118308; c=relaxed/simple;
	bh=0VteprcEpDdYYjRfxuID7OusfAG5C43xjucL+btNqTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ry8fz0g2ccT0q8Cat3+a0Jr0gQFlXZNM8cbkA057DYQYRe8t8tEe1Y1MPWdUem5zov70srq9VBTeG6v7E8UYnRlI8B6f6rmLRaiRyKpzmW3GK2A/Bb0BeuXZhMCK/Wy2InjFULplwVEco9BxYol7oQsCFailK3jKWj/684hSa0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XMaLq7Cm; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=0VteprcEpDdYYjRfxu
	ID7OusfAG5C43xjucL+btNqTQ=; b=XMaLq7CmWLhH2wCA5JI8ofSlndvb3UtajW
	OjK5E7jIXz/Dqh+/cs7+RUcu8lyAmt70nijFO+QL1dMe0d6cCxB8fSKDjwbRelLT
	+ce0m4dDqDw56P5R+gaoUEqdJHgUFQIzHvp1KYRqFzSWrtAyXbXMfyd4Ue6zMqUZ
	iq9Aoh0EA=
Received: from yang-Virtual-Machine.mshome.net (unknown [175.2.43.125])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wD3_9yJZ2hmWJzHAA--.35969S2;
	Tue, 11 Jun 2024 23:04:42 +0800 (CST)
From: yangfeng <yangfeng59949@163.com>
To: andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	yangfeng59949@163.com
Subject: Re: Re: [PATCH] net: phy: rtl8211f add ethtool set wol function
Date: Tue, 11 Jun 2024 23:04:41 +0800
Message-Id: <20240611150441.6798-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <c5fe08f6-6aad-4b64-8925-8f8ae1b26482@lunn.ch>
References: <c5fe08f6-6aad-4b64-8925-8f8ae1b26482@lunn.ch>
X-CM-TRANSID:_____wD3_9yJZ2hmWJzHAA--.35969S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZry5ArWUZw1DXF13tr47urg_yoWxArgEgF
	4DAa98tw129ry0va43J3s5Xw4jkr4jgas2vrZI934xKw1Yy3WFkF98trZaqa45KayxK34S
	y395tr1Igw4a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VU1SdgDUUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiTg-6eGVODf8mRgAAs6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

> Please explain in detail what you mean. Why cannot INTB be used?

The PMEB mode allows you to set up one of the wakeup events individually, such as link change event, magic packet event, unicast event, etc. And INTB mode is to enable all events.

> What happens when somebody else uses this PHY, say on an ARM system, and uboot does not set PMEB?

This code does not affect the INTB even if the PMEB mode is not set. The INTB/PMEB pin is designed to notify in case of both interrupt and wol events. The default mode of this pin is INTB(page 0xd40, Reg 22, bit[5]=0), if PMEB mode is selected (page 0xd40, Reg 22, bit[5]=1), the pin becomes a fully functional PMEB pin.


