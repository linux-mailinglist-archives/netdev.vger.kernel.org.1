Return-Path: <netdev+bounces-204497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AE7AFAE7F
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C743AE5A2
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 08:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C29728B3F1;
	Mon,  7 Jul 2025 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ppc5AJG3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EZhp3NBy"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627B429A2;
	Mon,  7 Jul 2025 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751876426; cv=none; b=amqKAoTckr72hhjWQLTu/df1STuxPdjdpVj+4me2Dbk3VENFcuQ/HdZ24Fh5bfdyhreiLmEcYRlR2fWVHorfo7Mv05U/5JPiYvx8RuDPbTHh+2/5JxZShdz+qHPYp9DZgcnW1I6K/cV7O2NQZ93bhVZwbLmqv07ThyuSN553FZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751876426; c=relaxed/simple;
	bh=viq5a1KqJz9xf/cTffzyhpUmiIUVUmS/GArPAHGcCO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qXyAVU7I4ZIlhDY5OmkAAfvNk/Vf782jgWtEFIMETMAilvXhlqcgIwNQl9exaKjP9qddbqBgdR2DdWAJGztUWiObFDZ/UOkfInOPa/dIsWrPBpHi2ddnCpn8xULfoKuxLdSzpK5v2VNg8CslWr6Y3SQhesbPv1iArSGnJyJ8Yng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ppc5AJG3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EZhp3NBy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751876423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJGHJr6ZnkCT7McQyMJ4zPUeUYnpJs0Ve//gpTmSn/M=;
	b=Ppc5AJG3Zc16b/Gc4WVYFMnXbL4UH4MNOOzbOUD3jyrr3kSF1RKBAwhyq/wMMqWC8Liu2V
	9Bd5Qu+ljoG1PZGHCP/8wU3R1jFSk6kyg+nPy1WAHpGY/zuPDYW8d0ZwbwcxYus0qPPT7N
	wwAqUkIcmW9f3xfsoA58q/jCHkpdozjBe+GZ9bSe+2A1D9sN2zT/Frb+QRwBaUG41AQ3qE
	prvh6PalR5Vo5Zd2IrqjknKJyPq0VHVUPTNbfKbBK+wHzH58hl+d3Ybo0cpwcy0HvJmgBQ
	46HD+8CDa6XYdN6Q/vB/+irdKF0hxhcgDrMHGtwFBie59DSysfrz91MMo2xa6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751876423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJGHJr6ZnkCT7McQyMJ4zPUeUYnpJs0Ve//gpTmSn/M=;
	b=EZhp3NBySJ/mPuB9b8y12bSpdoJyqiT8haJoLTmgj2kMAdh2pYYlTWOfR5B1O5d8wI1xcn
	Qkv03nqieNFDfHBg==
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michael Kelley <mhklinux@outlook.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH for-netdev v2 1/2] irqdomain: Export irq_domain_free_irqs_top()
Date: Mon,  7 Jul 2025 10:20:15 +0200
Message-Id: <f5d713428e6119f39cfbe359d5fcfb163844f321.1751875853.git.namcao@linutronix.de>
In-Reply-To: <cover.1751875853.git.namcao@linutronix.de>
References: <cover.1751875853.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Export irq_domain_free_irqs_top(), making it usable for drivers compiled as
modules.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/irq/irqdomain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index c8b6de09047b..46919e6c9c45 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1561,6 +1561,7 @@ void irq_domain_free_irqs_top(struct irq_domain *doma=
in, unsigned int virq,
 	}
 	irq_domain_free_irqs_common(domain, virq, nr_irqs);
 }
+EXPORT_SYMBOL_GPL(irq_domain_free_irqs_top);
=20
 static void irq_domain_free_irqs_hierarchy(struct irq_domain *domain,
 					   unsigned int irq_base,
--=20
2.39.5


