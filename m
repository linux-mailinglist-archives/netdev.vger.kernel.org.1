Return-Path: <netdev+bounces-15385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47EC74741B
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 16:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D8D1C209C7
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 14:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF82D63B9;
	Tue,  4 Jul 2023 14:29:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DDD814
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 14:29:00 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9418AE49
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 07:28:59 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51d80c5c834so10191653a12.1
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 07:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688480938; x=1691072938;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vGiy98QCO7ZtSd6I9GDg+GBkDb4CtqmQBijOnAOBgrw=;
        b=JmEsJqcImU//YdKRN0AdD3iJ6/7QXx27j/bDf0t+yXgOx/ROBNalYlEl9/S+jWJMsg
         dy8B612raf1TXhtPCmvGbAF/HzeLbEIEzu7uoJ6dQCibzGxj4TBPNRJpNCk9/5XfpMuD
         DKcbnuweCAnFp+nn51+g/3+pZZyfA39r5EBmLWxrMo9Wi738C9mz9eT8BZCkX7GF+5WA
         BlKhZMv8EyN4maKd8KxdFetAR21IeBnfAl+/r7S/AU1XHzVDUBlgrfCg66UGIkrUbobG
         2Ow9DvIWb38Sfzk0dkmAAVt36RLlPiByNkQyTC0pA7Ol6TsH7lEvZ8CoFzC01eZYwtVw
         PeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688480938; x=1691072938;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vGiy98QCO7ZtSd6I9GDg+GBkDb4CtqmQBijOnAOBgrw=;
        b=WXoLd2QnrpLWu55tNXnyBdDeahYCsGIprCPeTJj16LFJ4UjJ9nDoXqoF8Rht2M2ddw
         2LbiE0gdeeNc+wQxGNLTTem85OuzWcFL1i/UVFkNR2+CHspJysTX7MO1FzNw7Tnoa7rR
         ra8kHpN/z3uCmzT0CvjnBQqpsMo3KnbYrZnVPHxZvw+MESfO9xo7HqrEblqKuvEeoxsG
         2bY0qcCsUxI5UICWtnqLWuToyeoQCC/iuaWU8kNTbB4slc2XtoG16v2oQnrm4BU8Ukbq
         KUOeurkY2CensHm0xJyeJ/5xd0XCnsCwOlwvPHMASB9JxnSWguSe5qQKWgBJ89Mqq81R
         K4bg==
X-Gm-Message-State: ABy/qLYnJuxiptYUO8l9C09l+glfYRh46YV1FkZaTswM1GQpnPfz1T8Z
	LoAIpWmelKPNEfFZF8DgB0ofdVppZiKXM824LnDAJwBlXKA=
X-Google-Smtp-Source: APBJJlHFIzBM7PKK0kOkgj7CFmHWBCfSHC8fUnBMieBuuqkqYnFu2izAZSDS9iaex7fW+V84uNTBPW8lp0y7ZXkcQh4=
X-Received: by 2002:a05:6402:12d4:b0:51d:a012:ec2 with SMTP id
 k20-20020a05640212d400b0051da0120ec2mr12053556edx.3.1688480937877; Tue, 04
 Jul 2023 07:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sergei Antonov <saproj@gmail.com>
Date: Tue, 4 Jul 2023 17:28:47 +0300
Message-ID: <CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com>
Subject: Regression: supported_interfaces filling enforcement
To: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, rmk+kernel@armlinux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello!
This commit seems to break the mv88e6060 dsa driver:
de5c9bf40c4582729f64f66d9cf4920d50beb897    "net: phylink: require
supported_interfaces to be filled"

The driver does not fill 'supported_interfaces'. What is the proper
way to fix it? I managed to fix it by the following quick code.
Comments? Recommendations?

+static void mv88e6060_get_caps(struct dsa_switch *ds, int port,
+                              struct phylink_config *config)
+{
+       __set_bit(PHY_INTERFACE_MODE_INTERNAL, config->supported_interfaces);
+       __set_bit(PHY_INTERFACE_MODE_GMII, config->supported_interfaces);
+}
+
 static const struct dsa_switch_ops mv88e6060_switch_ops = {
        .get_tag_protocol = mv88e6060_get_tag_protocol,
        .setup          = mv88e6060_setup,
        .phy_read       = mv88e6060_phy_read,
        .phy_write      = mv88e6060_phy_write,
+       .phylink_get_caps = mv88e6060_get_caps
 };

