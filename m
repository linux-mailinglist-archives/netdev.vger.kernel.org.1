Return-Path: <netdev+bounces-37029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE287B33FA
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 15:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id E766E1C209C3
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 13:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854954121A;
	Fri, 29 Sep 2023 13:47:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EC7BE4F
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 13:47:48 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DF2DB
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 06:47:45 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-533c8f8f91dso14835944a12.0
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695995264; x=1696600064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zfSKrV/+BCjxWdAwT+qLB6i121VAZzQyutNHhNXbqi4=;
        b=iXBJVS9ir6jILCG6s7hMre2SVuovOg+Gk5b0qaVKhHardg7mcVw1MwNx3OX+j4xZ6H
         1PFCsy1LKtuzvprchN/akg1+yDIYBLUByQPL0cDMUX65GjSm39237ob5JRn3+CQFsVAy
         F+l3VbP0757HAHjXFweIjLDZ36l7T+f9Aoqi+7OpA62tn2/OtHsKYvJVec/oFFI88/BE
         8+no5DYQUeePI8kBqLH8KCqlt0I2D0GVqmlrKyd8EQW41hxXMYkx9Z+1oA6TO6n3HZT4
         +M7ztloa7SBWShhYnQMslySl7dvTWf2eKrZNmA306P7Inxt01enLMRU8SQ2hZ8fhFkty
         EJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695995264; x=1696600064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfSKrV/+BCjxWdAwT+qLB6i121VAZzQyutNHhNXbqi4=;
        b=BzsMkSH5WmWYQCFtIFmsnE3ShmKiTocRaXHOfDnGw+krf8y/8f80yqFIn0gqdw+hkO
         Zezx7fFP3Ko3Pw8vM4fCTw4rn8kcghvSZnbsKE8VMFvVNRlrA/zDm5Gt69z4V43dbEMc
         +5DA+XCob0w2rXu8FpxMFmiZZGsa1TRzH4JwmFG9i0rxOD1GGuXpWkNFESfVt8tz7AhS
         huVC6xSAZaezic3Y2w8DbSkWREV/Qj95joR18Egzc+hGrxWdAx7F1fvkE1z/JzZmLNro
         7wAKgQA2oAoMKpPzsPjygjiEUtnWVf+6EZRFP0h1slSBUksceLu3i9XS+1si5c9ZCC7s
         oTCQ==
X-Gm-Message-State: AOJu0YxP6VWH5aR1cJvhvpE0nnX+/VwhHh2Bk3fbdv5DH5f7mn9SsZA3
	khKQEm7RlJQgnmbsm4A4acGF+j223UVOD6L3dro=
X-Google-Smtp-Source: AGHT+IGGLXzFp2fICDMigoqoaKVIUY/choIIz/1mSaoVfhMV1v7m8YejOZ8MLKSvRXLxlfRCx7k8dA==
X-Received: by 2002:a17:907:7786:b0:9a1:bd53:b23 with SMTP id ky6-20020a170907778600b009a1bd530b23mr4121841ejc.14.1695995264274;
        Fri, 29 Sep 2023 06:47:44 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g5-20020a17090670c500b009a13fdc139fsm12403719ejk.183.2023.09.29.06.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 06:47:43 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	donald.hunter@gmail.com
Subject: [patch net-next v2 0/3] tools: ynl-gen: fix subset attributes handling
Date: Fri, 29 Sep 2023 15:47:39 +0200
Message-ID: <20230929134742.1292632-1-jiri@resnulli.us>
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

Attributes defined in an attribute subset should just specify a list
of attributes of the original attribute set. The original attribute
definitions should be used. This patchset ensures that.

Jiri Pirko (3):
  tools: ynl-gen: lift type requirement for attribute subsets
  netlink: specs: remove redundant type keys from attributes in subsets
  tools: ynl-gen: raise exception when subset attribute contains more
    than "name" key

 Documentation/netlink/genetlink-c.yaml      |  2 +-
 Documentation/netlink/genetlink-legacy.yaml |  2 +-
 Documentation/netlink/genetlink.yaml        |  2 +-
 Documentation/netlink/netlink-raw.yaml      |  2 +-
 Documentation/netlink/specs/devlink.yaml    | 10 ----------
 Documentation/netlink/specs/dpll.yaml       |  8 --------
 Documentation/netlink/specs/ethtool.yaml    |  3 ---
 tools/net/ynl/lib/nlspec.py                 |  2 ++
 tools/net/ynl/ynl-gen-c.py                  |  2 ++
 9 files changed, 8 insertions(+), 25 deletions(-)

-- 
2.41.0


