Return-Path: <netdev+bounces-99714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B0B8D606F
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D56AB2431C
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 11:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378A315575A;
	Fri, 31 May 2024 11:16:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8B0745E7;
	Fri, 31 May 2024 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154171; cv=none; b=a6oTDFUphKbY2OhoJl32KGYlmFzn7tbrsUpEE3Ljvl8iCqRHr5/bmLGb69CVD5esPaOydpwq1kMd2fMPYL62hbyILa5Ev+QBDDCU8ch+xfNqUIpCvadJtk9VdrBcdb9Ezf2zAUhmBONWYhYkAreJXuMG6dz1Aui6zXbO5UQIMQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154171; c=relaxed/simple;
	bh=nO788btYOfbgY9PwApNR0EY21VGu1jdGSBnrLexNxD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPnIqfFwlI0qlUbXQGBB+ySY+3xRfS4ink94J0ylSjb4REZvbjX3n7cwgZFl6HEfvC07hXDFBkuS+1j5qPUINzD2MO0IqCPaOmUwUGgoFXRKGjI3Go/VeE3wSdBaEIg2GThCOWHtbnQelNhrIgcUfXxNHRhRvsAahDQa08JEP0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a688d7e0eceso30387966b.3;
        Fri, 31 May 2024 04:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717154168; x=1717758968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JKt3epdML/t49nbGx1wXSnWIf2u7N7ttQPQyMq5sDQ=;
        b=ooVLmeT9pQ1NTrw1HptnIdHITY4sk/RtbIUp9u8sqoJIyxcBl/wOEDb2IR/Ca6BOdq
         plQUCZhOaGxD8HZb4OXOe2oNTkVxK93cAY5998vzySn8jPbj95vMGotP8Q0289QO0lnE
         jqrnVdEhr+Wh6ZadAqusrJvvTvfnQZvIn6akjNjfoDE0MXoz4RYt7nLRMYAbM+Y8gyzA
         347U1rrUBJIa9X0HgVOpKIuRf/34PaCmQ14AsxCNFmDHmH73CB0Ur8WShF31vrdJwnnc
         zxnF7ILJq6HcrXFAvH3lkslEA2o8KHYQWhEeLo9zg5fRfAF5EQE6PLbztU2AMG90XUtq
         dNjg==
X-Forwarded-Encrypted: i=1; AJvYcCW0jthuyOeEkBYmijw2CIEVE0HgYlMzpNcBATD+s94aq+0w4Mcrbvf31nKTrkd5QeCvEaclVWf9vA3ZOtbnrzP+fzgHmr0julIWwBUj
X-Gm-Message-State: AOJu0Yy89fthta56xLrY8XY/BU/pSSok+/Q1uxuP3DjhnZfoBaP8dHID
	NTFsb7HMVU/2RHinfD55nFNgPHVlVFNmXiX/VVbW+oc9hjs71mLZ
X-Google-Smtp-Source: AGHT+IE9d7L0hI9U/YFi+ikwDoPuo687q9bP9rT2JoqNkinpNTzbi+zZI8/8ks50byP9jTfg7k0DGg==
X-Received: by 2002:a17:906:e246:b0:a64:eca6:b15a with SMTP id a640c23a62f3a-a682204999bmr116166166b.53.1717154167812;
        Fri, 31 May 2024 04:16:07 -0700 (PDT)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eab85be4sm74865566b.157.2024.05.31.04.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 04:16:07 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	dev@openvswitch.org (open list:OPENVSWITCH),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/2] openvswitch: Remove generic .ndo_get_stats64
Date: Fri, 31 May 2024 04:15:50 -0700
Message-ID: <20240531111552.3209198-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531111552.3209198-1-leitao@debian.org>
References: <20240531111552.3209198-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
configured") moved the callback to dev_get_tstats64() to net core, so,
unless the driver is doing some custom stats collection, it does not
need to set .ndo_get_stats64.

Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
function pointer.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/openvswitch/vport-internal_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index 7daba6ac6912..4b33133cbdff 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -85,7 +85,6 @@ static const struct net_device_ops internal_dev_netdev_ops = {
 	.ndo_stop = internal_dev_stop,
 	.ndo_start_xmit = internal_dev_xmit,
 	.ndo_set_mac_address = eth_mac_addr,
-	.ndo_get_stats64 = dev_get_tstats64,
 };
 
 static struct rtnl_link_ops internal_dev_link_ops __read_mostly = {
-- 
2.43.0


