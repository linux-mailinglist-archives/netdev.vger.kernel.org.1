Return-Path: <netdev+bounces-13800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCAA73D0B4
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 13:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F9C280F6D
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 11:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635625670;
	Sun, 25 Jun 2023 11:54:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5862A6112
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 11:54:59 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3301EE45;
	Sun, 25 Jun 2023 04:54:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fafe87c6fbso552478e87.3;
        Sun, 25 Jun 2023 04:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687694093; x=1690286093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsYPlWkKWx54UKPOm+m2MAyy1P9pH4wm4DWIQ7hUyQk=;
        b=itKXmVf0xhP6VzvddpCCYnLfK/tjp7wyGswQxWjwGU83DT2ubn/z9kWl4FH74WCMrn
         M8ah1F5NX8gr4x4bFqn69m3zyuG0OSLngUw93/a7wgmRUzbhZBwOkBJUQRctLUWSyFmg
         bu1fNztbTsUNfhWHM5VfuHNzRPNrIeFT1xwCI2rCKsPG8q9wEvr6ScDGcSzR5emo7r20
         Z6ewTQOfh29je93tMjeg8v6HjVy68cTe7EnuEQ3Hc2R7Qb3+a8k+8fb5i2GlLCXb2hUv
         LEbsbKjmM0CNRAUY1Rj1FUz1/PV5WVXWgb2GcqTkcx/wHmw+r9fW2ZmgrqUyQCA/2s1H
         CfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687694093; x=1690286093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsYPlWkKWx54UKPOm+m2MAyy1P9pH4wm4DWIQ7hUyQk=;
        b=Ufr3JJ+vWMPGuknK6qjwZ3WRPfoFkUkNLyfY+fgBKHdI3iKonjARul+Q1ZpbQUWRZ7
         SWehHfI0SGL2unpAVKsdlC6DVTE0gQwgCF2N5kQ1Ot+B+RFbfRuphKkeqYadsC1gTsEi
         PyHv8UkdoSnYIwLQTWByMUSLM5D6SXLmhiyH611gGt8AMQKRINQ7VDlEpbO84atJGNSt
         jwzU+HB+CQDY31l+4cRW0y2FXPkugCCeXJB3OSODhCP7/SuKpHAF9vmejDR5HeinGeib
         FJCYaI1guIiVb9CkwCS0mZqU4LlVfClZT9dvHapMj22ViUdCRfUgSdPHGTAQZTGmUao/
         Jwhg==
X-Gm-Message-State: AC+VfDx0/XA9PU8gXjp3KTTA2JJQmTKwUumJ4Ke+e7TKHAQFRBChQ0Db
	yupA8gRFQZeaJBryybXwJ/hg9abGjW6lKw==
X-Google-Smtp-Source: ACHHUZ5+xI2K1G7gj8JY8uHTk9PI6ZEt5Y8M7C0xxDnsdvDu477m8AvCc6wM1p5RgG1YQQdXSIlAZw==
X-Received: by 2002:a05:6512:3e25:b0:4f9:70fe:d92a with SMTP id i37-20020a0565123e2500b004f970fed92amr4177442lfv.5.1687694093127;
        Sun, 25 Jun 2023 04:54:53 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id w21-20020a2e9595000000b002b6993b9665sm416043ljh.65.2023.06.25.04.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 04:54:52 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 5/7] net: dsa: vsc73xx: Add bridge support
Date: Sun, 25 Jun 2023 13:53:40 +0200
Message-Id: <20230625115343.1603330-5-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625115343.1603330-1-paweldembicki@gmail.com>
References: <20230625115343.1603330-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds bridge support for vsc73xx driver.
It introduce two functions for port_bridge_join and
vsc73xx_port_bridge_leave handling.

Those functions implement forwarding adjust and use
dsa_tag_8021q_bridge_* api for adjust VLAN configuration.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v2:
  - no changes done

 drivers/net/dsa/vitesse-vsc73xx-core.c | 69 ++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index f7c38f9a81a8..457eb7fddf4c 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1304,6 +1304,72 @@ static int vsc73xx_vlan_set_pvid(struct dsa_switch *ds, int port, u16 vid,
 	return 0;
 }
 
+static void vsc73xx_update_forwarding_map(struct vsc73xx *vsc)
+{
+	int i;
+
+	for (i = 0; i < vsc->ds->num_ports; i++) {
+		u32 val;
+
+		vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			     VSC73XX_SRCMASKS + i, &val);
+		/* update only if port is in forwarding state*/
+		if (val & VSC73XX_SRCMASKS_PORTS_MASK)
+			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+					    VSC73XX_SRCMASKS + i,
+					    VSC73XX_SRCMASKS_PORTS_MASK,
+					    vsc->forward_map[i]);
+	}
+}
+
+static int vsc73xx_port_bridge_join(struct dsa_switch *ds, int port,
+				    struct dsa_bridge bridge,
+				    bool *tx_fwd_offload,
+				    struct netlink_ext_ack *extack)
+{
+	struct vsc73xx *vsc = ds->priv;
+	int i;
+
+	*tx_fwd_offload = true;
+
+	for (i = 0; i < ds->num_ports; i++) {
+		/* Add this port to the forwarding matrix of the
+		 * other ports in the same bridge, and viceversa.
+		 */
+		if (!dsa_is_user_port(ds, i))
+			continue;
+
+		if (i == port)
+			continue;
+
+		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
+			continue;
+
+		vsc->forward_map[port] |= VSC73XX_SRCMASKS_PORTS_MASK & BIT(i);
+		vsc->forward_map[i] |= VSC73XX_SRCMASKS_PORTS_MASK & BIT(port);
+	}
+	vsc73xx_update_forwarding_map(vsc);
+
+	return dsa_tag_8021q_bridge_join(ds, port, bridge);
+}
+
+static void vsc73xx_port_bridge_leave(struct dsa_switch *ds, int port,
+				      struct dsa_bridge bridge)
+{
+	struct vsc73xx *vsc = ds->priv;
+	int i;
+	/*configure forward map to CPU <-> port only*/
+	for (i = 0; i < vsc->ds->num_ports; i++) {
+		if (i == CPU_PORT)
+			continue;
+		vsc->forward_map[i] &= VSC73XX_SRCMASKS_PORTS_MASK & ~BIT(port);
+	}
+	vsc->forward_map[port] = VSC73XX_SRCMASKS_PORTS_MASK & BIT(CPU_PORT);
+
+	vsc73xx_update_forwarding_map(vsc);
+	dsa_tag_8021q_bridge_leave(ds, port, bridge);
+}
+
 static int vsc73xx_tag_8021q_vlan_add(struct dsa_switch *ds, int port, u16 vid,
 				      u16 flags)
 {
@@ -1342,6 +1408,7 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	ds->vlan_filtering_is_global = false;
 	ds->configure_vlan_while_not_filtering = false;
+	ds->max_num_bridges = 7;
 
 	/* Issue RESET */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
@@ -1452,6 +1519,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.get_sset_count = vsc73xx_get_sset_count,
 	.port_enable = vsc73xx_port_enable,
 	.port_disable = vsc73xx_port_disable,
+	.port_bridge_join = vsc73xx_port_bridge_join,
+	.port_bridge_leave = vsc73xx_port_bridge_leave,
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
 	.port_stp_state_set = vsc73xx_port_stp_state_set,
-- 
2.34.1


