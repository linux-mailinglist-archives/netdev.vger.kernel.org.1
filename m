Return-Path: <netdev+bounces-251965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFbyJjQPcWlEcgAAu9opvQ
	(envelope-from <netdev+bounces-251965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:39:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1AB5AA93
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 174E962F70A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4363348BD48;
	Wed, 21 Jan 2026 15:56:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EB14779A0
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010987; cv=none; b=j4iA4VdkpvpSZ0L3Cu+ZV9HiOnigk9wTYlg1+VkDGPC8QFkeBquTylp5gZ+V8GvpR62elSktG6NZw+suJMhtbqVkylrbpBjV1bVqZ8m4ezg9gZz86dPP2SH2zT/bWHnTNUbix0aO18XcDbgu3LL6locUMYizht56IiQYftaJM0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010987; c=relaxed/simple;
	bh=T8U9YBL53JqT7WigLAduxBIVpfy/A2owaIdOZQB9pK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LEziCHdL7znfm+SLi3E2DH7iACRtgp318YzyDmkgYkuH8M+1/WMpB7TIZDMpPDgGYccQft8Zt8sy6NkZO6p3PICzGTTwt312Nf1OzDzoaHliwQ5QDn5LKQVKmeTK9TxqAN8xcsA5E1HJ6sBgTmMWfNOQkkskdQFCKuIyzge7PzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-4044d3ff57bso15382fac.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010983; x=1769615783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ek0t028DajpwRbdMOHJ1y71aPEyjkP5BEsLC81+5e0M=;
        b=iWPzyLz9byGZb98P9QNoKO+Dz1eNdUodsS1kvqYO84DzORymHYu8WWdDN0HSvyUrCG
         boNCPikRnz49WDFfDPKSZmEOPOvPqAaQXWPipkOFnjQfYGLEdFXi2DA2zflzuaxsO8k1
         Cc7DI95Wgj4nJsXE0rUEEEez8ZF920HZFiG3jFqLLh/8dUpj3KCLmXCsTT99XioDcpFx
         oIe58nfnwIY68ihnjer7cRggZRmBxyte1DOCId8hgAtDDfVn0MG5+Kou3OO9GiPIqI8p
         zU57hzJmor7CwpQ7TdPprzLF9/vxKhlrNkE8V5TF2tdkS69PiFipfw3lMWrQ19sh4tbJ
         Z5Yw==
X-Gm-Message-State: AOJu0YzAnuvcg5ehhPnqWgOQXudKNgOy9WIiqBMyOu8D1BPMbjAHzQIH
	drpzaYDqn3QwKVIHpxy06QNHQdhoFLKhPwAQk11+a29Qz3L/eFcv5Wr7
X-Gm-Gg: AZuq6aIG6IxFX1Ie/+3vOiyQAZl+mFs9PKEWzDm7aYPsrsF4SJA1ghZmlo7JYsZcZ+h
	26YlxRbvbD/Lte0akB6y1CEJ+UFaph3YALGxNMvZ2TqkT261iM8qSbBzTGrf8DZfFCkWJWEsSPH
	tjpMziv0ohl4r0fTInuwvQDnx8Vmf1/RqkfmXRK8dyqkXyDysrqnRzUAOofn8bCs1aZrEOOOouy
	TpaAA1iz2P8RzLrT+5jA6nFTthBLDVBUlQO2YMSlh9ZBufQxVjXViH+TdK7EUGmZXEuX5F6vVYy
	moFBOiWU12Ey4aydqzY/3S4PnqRa/8RDaUZy4JWvDwqc0wN/bQ9qzPTggoatnQXmqyzRZPauMfY
	qK0hAG51uDWsgWA5MVidx7A5Zh7t3mmjH3+KQeh5HNPMWZz/aScFDS+QVQcgMJXhuBEyUVB491X
	Mw2w==
X-Received: by 2002:a05:6820:458d:b0:65f:6d50:e41a with SMTP id 006d021491bc7-661188d51efmr5368293eaf.15.1769010982826;
        Wed, 21 Jan 2026 07:56:22 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044baf52f3sm10966601fac.2.2026.01.21.07.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:56:22 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 21 Jan 2026 07:54:40 -0800
Subject: [PATCH net-next 3/9] net: nfp: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-grxring_big_v4-v1-3-07655be56bcf@debian.org>
References: <20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org>
In-Reply-To: <20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
 Somnath Kotur <somnath.kotur@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Igor Russkikh <irusskikh@marvell.com>, Simon Horman <horms@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Edward Cree <ecree.xilinx@gmail.com>, Brett Creeley <brett.creeley@amd.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 oss-drivers@corigine.com, linux-hyperv@vger.kernel.org, 
 linux-net-drivers@amd.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1605; i=leitao@debian.org;
 h=from:subject:message-id; bh=T8U9YBL53JqT7WigLAduxBIVpfy/A2owaIdOZQB9pK8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcPch+6e/Eu+iQKP10pTrr3CuNmT6FBdEQqk9M
 xMfYtB4256JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXD3IQAKCRA1o5Of/Hh3
 bQcsD/45AXMgZGsQVC3J9pUfksTc1zQn1m85PMlFNKytYDezn7OrWQabGu98CEQ/ymbdPzZScix
 j3P16XF7hrTPu18ir6yQ1p0vHBYbgHTyZduh/10/ZqD1Wjt5twHKeDSwVrSSKI5m8/ao//PpQ5T
 5g+CoNBuuAHZH0dK/U3jaWUQYhblyFoYJE/6LBDcIGOdAF2fOscjXfXD0lQe2FCYHIms2Mo3qXq
 7yCGgpbIu9v9bVvFoGf5vE38eIb+o5qwcKvu0bNa8/JGWnHaZJFqnXyM0cUaJeSL1g//EsviHx6
 mUxC6Cvt3DQW24HTiV3b+8r2w1wskZeDbix23XbmcCEeipg1XgUvWoSRb7wyxzCvQA23kv82H+l
 6yVwpoSAD1Fe2rH0QS+wkkr5VUakvdufnE/ajUGEs5g+ptYA7S5YeqtVDlONQB1lkX7jXMs/W76
 dIXqBNeNKmqEEL7VuQ/ES1PR52/XYKTXByWcDGbp1WvLB9nVWEWrhrm8XEl4gsoo1rhoDoPcxib
 xKDiUs6sb37qHSZCfF885e6jhUh5IHEPgN+Sr3YEyqhmxi/XYZafLNuSFEuCbHL8q289u3iC4hl
 1T5VTD3cvXEcBZyD0xsUzap9CWNxbqssjWJwp00B3fCYVB0raH/qSKLtHAEi517Zh8fzuclqokw
 cE+RB1zkrcsNTyg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,microsoft.com,fb.com,meta.com,gmail.com,amd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251965-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 4B1AB5AA93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
index 16c828dd5c1a3..e88b1c4732a57 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
@@ -1435,15 +1435,19 @@ static int nfp_net_get_fs_loc(struct nfp_net *nn, u32 *rule_locs)
 	return 0;
 }
 
+static u32 nfp_net_get_rx_ring_count(struct net_device *netdev)
+{
+	struct nfp_net *nn = netdev_priv(netdev);
+
+	return nn->dp.num_rx_rings;
+}
+
 static int nfp_net_get_rxnfc(struct net_device *netdev,
 			     struct ethtool_rxnfc *cmd, u32 *rule_locs)
 {
 	struct nfp_net *nn = netdev_priv(netdev);
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = nn->dp.num_rx_rings;
-		return 0;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = nn->fs.count;
 		return 0;
@@ -2501,6 +2505,7 @@ static const struct ethtool_ops nfp_net_ethtool_ops = {
 	.get_sset_count		= nfp_net_get_sset_count,
 	.get_rxnfc		= nfp_net_get_rxnfc,
 	.set_rxnfc		= nfp_net_set_rxnfc,
+	.get_rx_ring_count	= nfp_net_get_rx_ring_count,
 	.get_rxfh_indir_size	= nfp_net_get_rxfh_indir_size,
 	.get_rxfh_key_size	= nfp_net_get_rxfh_key_size,
 	.get_rxfh		= nfp_net_get_rxfh,

-- 
2.47.3


