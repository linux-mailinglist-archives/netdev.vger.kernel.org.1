Return-Path: <netdev+bounces-277269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCRtGPKZ2GkgfggAu9opvQ
	(envelope-from <netdev+bounces-277269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:34:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F20673D2D1D
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66BBC302EA9F
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 06:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152AB38A728;
	Fri, 10 Apr 2026 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="GrCv/tBH"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D10386C3F
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 06:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802828; cv=none; b=CP/MQ2Jp9NDK8YFHmNvFgTUGb8uVHyFYDHMIl1R+fk4c7rwhpIjhndZIC8TlB3pa+hnWDnDIInKs6l1re1kFv8/hcMlmYCEBarqgmE/9JKverkOWdwMPMl5SjkCtu8J69xoNCAy/TGkirg4WBJj1vA9aE1elHRmmTdxJCCaHffA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802828; c=relaxed/simple;
	bh=ZbrZQx8lkV+gKf7k3zFsSPYsl331L3D+ld56c5jncLU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ht+I2XAwA0/91ifsiRga4A8+0KHTkyl1qGHxKPZSlcnRv7NOXbMwpwrLiMj+Tas+EMfeLFSx5Gm+fBgTKLejWR1uP9jif5IYW4sayBTGIvpXiFpTegdAAsOTdn8qaF5G2NnzveAfJIaj4vnOWNPK6kUS/qgytTqMTNWWvc4oPjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=GrCv/tBH; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Zb
	rZQx8lkV+gKf7k3zFsSPYsl331L3D+ld56c5jncLU=; b=GrCv/tBHJeEAa9IeBu
	B90DaMRgs8v0SF573fqYOeqPLI3zCafetYum0sE6x4rf9qGmqeQ7zsrsMGI4j/kZ
	AATAx7kNLXOrgke5BUmN1HghPTrCt034JoItG6R/NvH8zsdcnAIVh0S99bRLq6Ic
	EFmYIL31yOb7tagnQZRv5GXSk=
Received: from YUANZM2-F4WK0J3.lenovo.com (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3fxq_mdhp439QBg--.60348S2;
	Fri, 10 Apr 2026 14:33:36 +0800 (CST)
From: wit_yuan <yuanzhaoming901030@126.com>
To: netdev@vger.kernel.org
Subject: 
Date: Fri, 10 Apr 2026 14:33:33 +0800
Message-Id: <20260410063334.7531-1-yuanzhaoming901030@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410060957.1336-2-yuanzhaoming901030@126.com>
References: <20260410060957.1336-2-yuanzhaoming901030@126.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fxq_mdhp439QBg--.60348S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU0iihUUUUU
X-CM-SenderInfo: h1xd065kdrzxtqjziiqqtqqiyswou0bp/xtbBogAnMmnYmcBYGgAA3d
X-Spamd-Result: default: False [0.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	EMPTY_SUBJECT(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[126.com,none];
	R_DKIM_ALLOW(-0.20)[126.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-277269-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[126.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuanzhaoming901030@126.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[126.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F20673D2D1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Please ignore this patch. It was sent by mistake due to i'm newbee.

I will send a corrected version shortly.

Sorry for the noise.




