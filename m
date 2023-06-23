Return-Path: <netdev+bounces-13541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A2C73BF60
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 22:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F351C212B7
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 20:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF3210978;
	Fri, 23 Jun 2023 20:20:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5213D7B
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 20:20:30 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E85619F
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 13:20:27 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6300465243eso8538036d6.2
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 13:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687551626; x=1690143626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=39s0juLuTUuu17ukxgzuT7ZGuaKD2vk73SD3uxS4Brw=;
        b=GX5Mt4JFhlWzpzFlaVjDo5+PjJHfQ7xQVV6Oe0P3iOORq6fZl77LOa6mOnp6R80/TG
         dYXurkADolOLIMadUOEE2Zx5fE7UrP070n4+6eyVnvyRurE87jb5db/eTL2InJ+nUeoK
         PBSHekI3cbxGx3X28kpheaBqfWptKbHCAqUNEisuPYiUboPK4wOqYLunuhyT7JaZp8hp
         e9b1v64jVrLi07l7NOcvmCQne/6zkbDS9p4agKsn4Yk5eE3xdAiCywOkva1UBmZWd0vo
         psQQ/HA6QUXmeEA+6O1Edagg/bEypwPw+8ZZtKYKfFnOefDJH6arbjLZdzfhPLhA/TX5
         vTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687551626; x=1690143626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39s0juLuTUuu17ukxgzuT7ZGuaKD2vk73SD3uxS4Brw=;
        b=KQRKPjQFuJKe/XfirYBUGG2gdNhi0sbfYZGsbr3USnkjxs5habZOkAwoVQQUAgaAT1
         fWjRRcjSZHn9iAnOlSWeEkop0C4SEa4sE0wXKuTUlhchceRUwW9ZvDR3IGRuNlKBLa0l
         fAqrC5T9jvFkGj0W6wR4ZynSPh9pO8DWBbCWGJiQjlv3pzTB46qTxTIlPdIKnXOtaqIO
         siQPWuyozYSboGr/tbvu4Xtn3wAjO/JIpSdB/59mJ7QCXo9ZNbITZJpFuUg4vJ7O0MAF
         mM1SBYHksZ71Ie4N0yjvJ/hI5UitXXh2QBc+f/srBDR2sRTsA63VSndv1Hc9rf8RiTDq
         tYNQ==
X-Gm-Message-State: AC+VfDzns+EP+6J+2T2STjza2BCZ1LvlOEpiWPuN3obejF/taAYfF0Cx
	rhJL0ksE6GApedZkoj1WMzjoMH2HUjopfw==
X-Google-Smtp-Source: ACHHUZ7JQNWuQyJcXjI3bHnjjCO8RCD7IBT5cOMriCjqr5GAXDhsc++mSaffa7AmEyofgqtDgW3xSg==
X-Received: by 2002:a05:6214:19ef:b0:62f:e761:50de with SMTP id q15-20020a05621419ef00b0062fe76150demr29196858qvc.33.1687551625826;
        Fri, 23 Jun 2023 13:20:25 -0700 (PDT)
Received: from imac.redhat.com ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id d24-20020ac84e38000000b003ff0d00a71esm2274152qtw.13.2023.06.23.13.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 13:20:25 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 0/3] netlink: add display-hint to ynl
Date: Fri, 23 Jun 2023 21:19:25 +0100
Message-Id: <20230623201928.14275-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a display-hint property to the netlink schema, to be used by generic
netlink clients as hints about how to display attribute values.

A display-hint on an attribute definition is intended for letting a
client such as ynl know that, for example, a u32 should be rendered as
an ipv4 address. The display-hint enumeration includes a small number of
networking domain-specific value types.

Donald Hunter (3):
  netlink: specs: add display-hint to schema definitions
  tools: ynl: add display-hint support to ynl
  netlink: specs: add display hints to ovs_flow

 Documentation/netlink/genetlink-c.yaml      |   6 ++
 Documentation/netlink/genetlink-legacy.yaml |  11 +-
 Documentation/netlink/genetlink.yaml        |   6 ++
 Documentation/netlink/specs/ovs_flow.yaml   | 107 ++++++++++++++++++++
 tools/net/ynl/lib/nlspec.py                 |  10 ++
 tools/net/ynl/lib/ynl.py                    |  34 ++++++-
 6 files changed, 168 insertions(+), 6 deletions(-)

-- 
2.39.0


