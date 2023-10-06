Return-Path: <netdev+bounces-38561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C017BB6DD
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 13:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915732822DA
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 11:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3161CA8F;
	Fri,  6 Oct 2023 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eJOky9up"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035D71C6B0
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 11:44:42 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54331DB
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 04:44:40 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso356182866b.0
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 04:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696592679; x=1697197479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KzNcf/a9IV0aNYpNsx/lguG0DnnAUaXz3h+CkDq52sk=;
        b=eJOky9upyj6IiJV6X1jcPmpQTDi7zqAhQJ9mHffq1m2wpvR8QOA6Az/kKvPGL5aECs
         B/6pwOpue5hFrJWLSzQeB9ZEU7HflR40NAi59S+0lIfXmjyqR+xbLQiX7LYW38Zv8ntO
         ACEESlxyBmX0Om0Y2bbSOUae2M8WUw8NdEnkaaTHlLPqUrkQOjr65r9lR9j+PhVVEoAk
         bqc97ghYJnfy5qCSySJLeEttpGjSEproi4sfal30E4RfBpO9WD0hvRR4a5mlvITrIpCN
         z7HeTsq/yX2kCEKCqjor04JbYKiYnvTsingIEQlZGVpdJij6OtRm7sRE3QoJgbgG9Juz
         CVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696592679; x=1697197479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KzNcf/a9IV0aNYpNsx/lguG0DnnAUaXz3h+CkDq52sk=;
        b=k5GTUIqAFs/fsHhKgFmIKhezvQIW8IzNr8GJyj4F3WAokkYSnZ4T0AvVe+6bxrMzZ7
         IM5+EyYY9rpLZUUP8dwL5shc26JdVorts4lGEfSLdPrt1yU2Q7BSPZvXzDwe4RkoDEBX
         2mdhwxHxji1uYz2vEPE+WQWFTJvnCmfGK8JJ6JlhuqUjx1mUSaw4osXU1viyXTVO5my1
         ve1P6l5snT6IBGhuc3vFkc6GNKV0q5lF7zMd3VUPjSdtD+HM7PbM7gCkjwpmO9rnJ7+F
         ++VWOp3yj0lShlKCenO5mIHqzJY13+tec9MlZMrmH7J9nJlCVdRD5JkLgReposi4fEkX
         qLvQ==
X-Gm-Message-State: AOJu0YyiEBe0qpBKxcZU+8G8yDv8HfUENQYH4TCLj03mDUjEp6FxCjKQ
	BtDRCinqMI+UY361HduxdZBm36uFgUJrnjHl+qrLTw==
X-Google-Smtp-Source: AGHT+IHbberFWOCn+yUMLPTlyhThnmMT0ShxCcRAJ99pMFtGI25nxcYKR8inRwUpXjJlRFXUYFObAg==
X-Received: by 2002:a17:906:31cc:b0:9ae:42da:8038 with SMTP id f12-20020a17090631cc00b009ae42da8038mr6334866ejf.74.1696592678627;
        Fri, 06 Oct 2023 04:44:38 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id qx18-20020a170906fcd200b0099bc8bd9066sm2759325ejb.150.2023.10.06.04.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 04:44:38 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	donald.hunter@gmail.com
Subject: [patch net-next v3 0/2] tools: ynl-gen: lift type requirement for attribute subsets
Date: Fri,  6 Oct 2023 13:44:34 +0200
Message-ID: <20231006114436.1725425-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Remove the requirement from schema files to specify the "type" for
attribute subsets and adjust existing schema files.

Jiri Pirko (2):
  tools: ynl-gen: lift type requirement for attribute subsets
  netlink: specs: remove redundant type keys from attributes in subsets

 Documentation/netlink/genetlink-c.yaml      | 14 +++++++++++++-
 Documentation/netlink/genetlink-legacy.yaml | 14 +++++++++++++-
 Documentation/netlink/genetlink.yaml        | 14 +++++++++++++-
 Documentation/netlink/netlink-raw.yaml      | 14 +++++++++++++-
 Documentation/netlink/specs/devlink.yaml    | 10 ----------
 Documentation/netlink/specs/dpll.yaml       |  8 --------
 Documentation/netlink/specs/ethtool.yaml    |  3 ---
 7 files changed, 52 insertions(+), 25 deletions(-)

-- 
2.41.0


