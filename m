Return-Path: <netdev+bounces-227098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 189C7BA83F0
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 09:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CBAC1887927
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 07:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1BE2C0263;
	Mon, 29 Sep 2025 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BgW8nD5W"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712602AEE1;
	Mon, 29 Sep 2025 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759131000; cv=none; b=sPbLFw1vgE+HXpwRtzN6EkEvFFD0W4edYeiT0EG/UuDjjq4VDV1pd5jGaUI0pux+50dLZq60glHPvGyZAmoWY6y3t134jxOBgfGuj6Jojfnu/vybB0uFSR9KWG55vCV8yrCaFvseH6q0HDtoweSwkqh9mP1L8DWizGunsgxrwhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759131000; c=relaxed/simple;
	bh=O28Rc/w9Fl4JFrzquNNJBvSX8v/hQ6DnpTrNiyIwY0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HyCDnhYqFOYlwaLDZo+1EQ0+s52x/Q1KruNHg794yiZE9VO55VrJVRKCG2d00orPROYWoE4q26MKHsHM2RdK2Tivg6gUfUik1rzg1tAcD/pHmrEEOjl9EkVN6BiBVhvTkii8gCUGPbKwfN8CSZaTDlKF7V8FgNQbeWjPWhEUnOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BgW8nD5W; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=O2
	8Rc/w9Fl4JFrzquNNJBvSX8v/hQ6DnpTrNiyIwY0c=; b=BgW8nD5WkNzoKoB8F+
	48orKPPBZ6bV8PWAshXUtDfi2UC3D74XQ51RnfnN6f7LkkQqUQggNAARwfc4wYCe
	Cy9bzBsNcDv5pNxFZSQhWuvoIVJhm3bS0mgJ9k48z4/NnLzz7qZN5x3WKWaGg09C
	21+/yW+fmP9I73I/y9Jwn0KvM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3J6U9Ndpojl23Aw--.62685S2;
	Mon, 29 Sep 2025 15:29:02 +0800 (CST)
From: yicongsrfy@163.com
To: michal.pecio@gmail.com,
	oneukum@suse.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org
Cc: marcan@marcan.st,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH v2 2/3] net: usb: support quirks in usbnet
Date: Mon, 29 Sep 2025 15:29:01 +0800
Message-Id: <20250929072901.3137322-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250929091153.4c769e44.michal.pecio@gmail.com>
References: <20250929091153.4c769e44.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3J6U9Ndpojl23Aw--.62685S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZryxWr17GF45tw48JF48Crg_yoW3Arg_u3
	4Dur93Aa1Utr18Wa15Gr1093sxKa10grn5Za4DJFZayFy7KFn5GF4vgFy3AFn3Jr4Fkanx
	urWrtan2qrsagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjbo2UUUUUU==
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/xtbBFAzX22jaLzCf7AAAsK

On Mon, 29 Sep 2025 09:11:53 +0200, Michal Pecio <michal.pecio@gmail.com> wrote:
>
> On Mon, 29 Sep 2025 13:31:44 +0800, yicongsrfy@163.com wrote:
> > From: Yi Cong <yicong@kylinos.cn>
> >
> > To resolve these issues, introduce a *quirks* mechanism into the usbnet
> > module. By adding chip-specific identification within the generic usbnet
> > framework, we can skip the usbnet probe process for devices that require a
> > dedicated driver.
>
> And if the vendor driver is not available then the device won't work at
> all, for a completely artificial reason. We have had such problems.
>
> At the very least, this should check if CONFIG_AX88179 is enabled.

Thank you for your suggestion!
I will add the CONFIG_AX88179 configuration check in
the next version of the patch.


