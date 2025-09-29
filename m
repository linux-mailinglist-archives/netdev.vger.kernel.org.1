Return-Path: <netdev+bounces-227097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3894EBA83DC
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 09:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC853A73DE
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 07:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06F7253351;
	Mon, 29 Sep 2025 07:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PE6izPRD"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DE62AEE1;
	Mon, 29 Sep 2025 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759130796; cv=none; b=T093lODf7W2/EJqGuQpoewxgbP3f1rM6Krm1GUWEndAnjfKZc+TNmEbkJ271VvKX6P7KyqC6kmEcAflM6DgbxG2lFIMB9r9Te4ne4v3RdXSkZNK5LsxHo6gVcumcCkC1dIsJ76F0QFhW5+CsMY90zIILjlIKsKesSRrYHGad6iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759130796; c=relaxed/simple;
	bh=5pihyOJTl6KpeNZGs5qJvOw7MQSuQZsVfKmuTx0ItuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jCXaRPTAcrmL/bvcLGn8Jc+3aWb7jKHN3ITBlOch2700T+zRrtHzXWnvuJYuMFNpED8fPr+sg32osH6LwjFQAj8YMlo1oXxW5h8uswxyc5+fcjCg48EqIWyiPVNGnQXR6aJaIgIdnFx+iStRG08xapBWJSRGfJZBbYeTHAKe5js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PE6izPRD; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5p
	ihyOJTl6KpeNZGs5qJvOw7MQSuQZsVfKmuTx0ItuU=; b=PE6izPRDOYxRO8/MbL
	sR2h8wiT+8LQe05d968E7LYxzZlAug0OKemMBtdIVbN8q7qS1vG/svLq9rCZy0ff
	n3OBFnCPdKRuk3HG704JEV1euKZyssnXhPAEdNuei4QnOCBztXt6lQC2EA2ZVGxw
	3idXfO28otWR4xcTvnyQ8hJGY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAX7wFZNNpoDJR8Aw--.446S2;
	Mon, 29 Sep 2025 15:25:15 +0800 (CST)
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
Subject: Re: [PATCH v2 1/3] Revert "net: usb: ax88179_178a: Bind only to vendor-specific interface"
Date: Mon, 29 Sep 2025 15:25:13 +0800
Message-Id: <20250929072513.3136507-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250929090229.2fa33931.michal.pecio@gmail.com>
References: <20250929090229.2fa33931.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAX7wFZNNpoDJR8Aw--.446S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw4DCw1DtrykuF1rKrW3Jrb_yoWfXFb_uw
	n3urnrGwn8AF15Xa1UWFsrurW3K3WY9ryUJ34vgFZxt34fXF98t3Z7CrnIv3Z7GF48tFnI
	kF95JFs2vw1fWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjnXo3UUUUU==
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/1tbiUBfX22jaK2roTQAAsd

On Mon, 29 Sep 2025 09:02:29 +0200, Michal Pecio <michal.pecio@gmail.com> wrote:
>
> On Mon, 29 Sep 2025 13:31:43 +0800, yicongsrfy@163.com wrote:
> > From: Yi Cong <yicong@kylinos.cn>

> > However, this driver lacks functionality and performs worse than
> > the vendor's proprietary driver.
>
> Is this reason to revert a commit which prevents the vendor driver
> binding to CDC or other unwanted interfaces?
>
> The original commit assumed that the vendor driver will never need
> to bind to them. What has changed?
>
> Isn't it a regression?

This series of patches aims to resolve the compatibility issues of devices
that have both CDC configurations and vendor-specific configurations.

In my understanding, avoiding the use of the vendor driver when it could
be used is merely a workaround; a better approach is to directly address
and solve the underlying problem.


