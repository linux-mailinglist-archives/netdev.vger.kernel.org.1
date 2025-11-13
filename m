Return-Path: <netdev+bounces-238456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 33369C5908B
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD60B364FAC
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A46635A13F;
	Thu, 13 Nov 2025 16:46:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34555359F88
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052377; cv=none; b=K7Kz57RB7xBvlvI9YCGNrrWp2vv8NmKrpydssNrZ9wMAo4/j+7uB5y5R+u89sshGJ967cOJu/ryuX6yMxFdKxo4D7cr1Zy4lcDEUIwVt8uyEE6WwpneEzPOTrJYreyE6c0SXju+yju2Yq/6T8NshkoHyZA2Lx3LIhtWEiCYZ1Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052377; c=relaxed/simple;
	bh=VGnC9M5GyCZAIUV5N/UMNwO6x7HUT0IBSW2UW8dHOTs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WmUqwyTzEzBTW4aezaciB05lDJzhnilx8JiRs4ogrppJIQ9XmkBjaxShOAdH0p8VoVsqAY1TztEuvBGTG/kpQtabdWdlfVPr0Hn10qKwEjGcRiTQKfHfh4YYxXDTJIICs6Pk3zyA85o8cT4gMX4aLJo/ZWvw1mqJKKbgn81Uex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c6cc44ff62so776806a34.3
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:46:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052373; x=1763657173;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Le654lwVo/6yvzyB42yjnqH7EJH3FTtiuiBest9Aydw=;
        b=rXn0GZT0cPu8jKfWyL0ZLkZlhmmeMYCmXOngwZu2DaG9z3GkxL6dTPG2HpVOBjclm6
         wz3jZ6XCu5pz1XO4q/oclimmn94YhcZNlGBvCCucL6RQawgrkk/v0FO/lGwmYt9/I8hB
         RtX3JsQ4pUqRQWawQzA9KSQadne95sV6NfzH/u4PC8528KLgLtuuTrRPbSnTz+me0ONX
         XZOHbOX8ytwoJm/qbo0nNzdQRlzzDY5eK6OzvRBGid/wrAveYTvraNSA1b5pSHUkJDGx
         y1113/X1pF69uAYldXD7tOsESu5cdwGAv6FlYWy2FehyH1upMw6Lni9vW90d0R28VBJc
         Bf0A==
X-Gm-Message-State: AOJu0YygQ1lcmRREZLxU2Ed+HYvyLOxD1jHWM38u+dCh1snEqCcDJ6xE
	atgL7nFFU/DkTQ/v+TxZn9uczRNU/T63KEjlbRaD0k/lsfjsUiieapPZ
X-Gm-Gg: ASbGncuhXImTJT6MtjJdw4IQotDm4vH7lG3LtD/0ruVCZUUoSVYOHzx6jUjr2pT02Fh
	dzJH6EdbacW9u9N8baDr96OJR3VSaWRM8ASXqSE9OwXz7KNgOmS3BWVk04k5cFV2n3WwacJIgOs
	r8ju7VUPucby5QUUgjFgIDVgPrlmllbmJtwTMTdETnkpcUkrIMPKGR2ar7Z0zC4btYpJKK8pV5n
	nVigE5gqxdMAfW40Lp7NoiBDxZk+sV2x68Qe94+Kb+DVZ4z/MwCZKH2g4rAmi+2LTfOd2XDFiuS
	k1YK3iM83PZ9jGQhmWeWcSoqvTIA2UPlYJvy+BlL97lcxFM5M8ym/Xm0zq0MgRJ1r0xXfH5M0Sw
	W09u+W1zZXTOgpyBMMGT2Dijes8FCdIC+n23iMILHUO7++uICxqakas9QtJabqIhCWdsi5B2U8F
	xUTw==
X-Google-Smtp-Source: AGHT+IHMlldWyJC6JRWEYFYT1iL5gomLD7IIC4KMdUcHwaxmTiV3LQSm9YXqc/Il2hpg7iYHwyqiKQ==
X-Received: by 2002:a05:6830:67da:b0:7ba:8107:d559 with SMTP id 46e09a7af769-7c74454ea64mr121594a34.26.1763052373137;
        Thu, 13 Nov 2025 08:46:13 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c73a39310csm1490035a34.21.2025.11.13.08.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:46:12 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH 0/2] net: mlx: migrate to new get_rx_ring_count ethtool API
Date: Thu, 13 Nov 2025 08:46:02 -0800
Message-Id: <20251113-mlx_grxrings-v1-0-0017f2af7dd0@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEoLFmkC/x3MQQqDMBAF0KsMf20gY5tFcpUiInVMB2osE5CA5
 O5C3wHehSqmUpHogsmpVY+CRDwQ3p+lZHG6IhFGPwZmfrj92+ZszbTk6jiGNYZNvMQnBsLPZNP
 2715T7ze2omJYXgAAAA==
X-Change-ID: 20251113-mlx_grxrings-195d95fe0e94
To: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; i=leitao@debian.org;
 h=from:subject:message-id; bh=VGnC9M5GyCZAIUV5N/UMNwO6x7HUT0IBSW2UW8dHOTs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpFgtTGtn9i7Py9ec07FVPLZv/6rFQlwLiE6XVC
 6+4CuAYJhqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaRYLUwAKCRA1o5Of/Hh3
 bYrZEACULVWobdnQ9efzrcFpilU50BH9Lh3TGK7pgRlVM29ZOju0jvQacwOi19SlHukYZiOnmW8
 yKgdmIVbPFSYuCgIcHTU6SUQ4W2LDKqDenwbmKJiTNVGgr91vWVhms1+0hT5EOtCfzvPZjmWaIF
 uv4ZRJiT088YQUbMrVIORBqpOICaKHx8Qm+lN+6uSnd7pfDT05W9PNlBoMaJoMnG0Ds0gTfot4h
 s2+CsizvYVB2M7ij2zxJh8xIkY0WjFd2VoZXuij8yZK4sXJhDKnIe6FEqTbs/KoTBEhpbpr7ech
 wvQGJEKIyeoZK5xN9f8gvt4wkOrnsbVi9U8cxelWfeeOPgxX+mnDVEOiPweFUO6N3KXy2dNSbhB
 j9QQzvR9361xkSpftm2D2A2IloduQSnM7kNT5tbrM8qjR+w69UftVJ5en4VobiHw+4nwFXWxHW5
 5r7N3W7m38YKbTgcXfF9cA7lqiyqyJLYDoGrAYPjupKQoqhFCplb3uR7aYShy4HeuioYeo3ZW3x
 5Vd0CyLn14g41jd8WTraQpkuAFRE+V4C+qozgMkI21bJwyOcRzrRiBHqrZpVzEfMWxfbZjLR3II
 /4Uqcgmh/AjJnxOL7tKsLW/dFHTjhxC66B7Gd+UYoDtwbFVczLz7X2CS+/N9JAPHZ7VQ84HpgtI
 0IdnQAAKtiQKs0Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This series migrates the mlx4 and mlx5 drivers to use the new
.get_rx_ring_count() callback introduced in commit 84eaf4359c36 ("net:
ethtool: add get_rx_ring_count callback to optimize RX ring queries").

Previously, these drivers handled ETHTOOL_GRXRINGS within the
.get_rxnfc() callback. With the dedicated .get_rx_ring_count() API, this
handling can be extracted and simplified.

For mlx5, this affects both the ethernet and IPoIB drivers. The
ETHTOOL_GRXRINGS handling was previously kept in .get_rxnfc() to support
"ethtool -x" when CONFIG_MLX5_EN_RXNFC=n, but this is no longer
necessary with the new dedicated callback.

Note: The mlx4 changes are compile-tested only, while mlx5 changes were
properly tested.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (2):
      mlx4: extract GRXRINGS from .get_rxnfc
      mlx5: extract GRXRINGS from .get_rxnfc

 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c        | 11 ++++++++---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c   | 18 ++++++++----------
 .../net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c    | 18 ++++++++----------
 3 files changed, 24 insertions(+), 23 deletions(-)
---
base-commit: 9f07af1d274223a4314b5e2e6d395a78166c24c5
change-id: 20251113-mlx_grxrings-195d95fe0e94

Best regards,
--  
Breno Leitao <leitao@debian.org>


