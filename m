Return-Path: <netdev+bounces-21903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86634765329
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 14:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E27A28231D
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 12:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF9E1642E;
	Thu, 27 Jul 2023 12:04:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13491BA4B
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 12:04:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3289B2D67
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 05:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690459439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/MRE01QPniJR1JCiS75DdG9fD09JsHpWtVhmyCi/50o=;
	b=L5g3mGuhiCEHIoCaQZfRu2myVCK1c2qNDWwCitnw/wVdZntcv/DvfqZHY1SVHYNPtY2vBn
	GOtA8Vmci6/CotH3AES/n4bQXIH7+Ql9xCe//3pBURp7bvAs0xMQylroGYGck+m/Hwc/Kp
	VwMVUcOtID3x1aszKVGdILyJvQUyumk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-Cf0teakMOAOI8oUwXoMQ6w-1; Thu, 27 Jul 2023 08:03:58 -0400
X-MC-Unique: Cf0teakMOAOI8oUwXoMQ6w-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-63d10c323c3so11481576d6.0
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 05:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690459437; x=1691064237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/MRE01QPniJR1JCiS75DdG9fD09JsHpWtVhmyCi/50o=;
        b=QelyTk7LZgXBuWZrv+Ustel0gQfHFSRjtakLiSDbFhzKQDDWYYEqynhrHhC/FR0F9Y
         x3SFr1mFjzoDPO7Q9Zqfe8usudCo4mWlaP3GcURbln/2MDEB+QsyY07xn0QTSBxk13UG
         vLqEm6FyYVp1ZpeZAkiyMsXRj+I/PNjUKZrdq+BRahPY+PrKE8B8pjMV/c1PARVoiDo+
         cpMtgFiURMGCXhInMIghAHtOCc5aOIUlexsyjdjnsm9qZ0fBc/Z9CB2KtlA3OhIjPLZP
         diU+uXim82kM8fNWLFicG8vVwBsiK9528VihRHWgUINK/Y8bRpjkBf/LDrtFp6ne24xs
         u8bg==
X-Gm-Message-State: ABy/qLZ5p3O1oCea3Vdy10EO9TNFWWUnAkdhUTnt0JEvrGWyKojzj8fp
	CFAOFdHdESlyqoupLky32TAkmlkjl7EzWx11yNzeFWN3+pW2bkaEYp9dQwLwPRIuNE9HJ4N0kPw
	5LCHVQPLcbLviDluUzWuXXjqGvTRkk2BMbUwNxXfFgvfQ4WReat2GgGvsfd65jJ3KV6RSosjXax
	khRA==
X-Received: by 2002:a0c:f30c:0:b0:635:f412:6a75 with SMTP id j12-20020a0cf30c000000b00635f4126a75mr4549900qvl.48.1690459437278;
        Thu, 27 Jul 2023 05:03:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHZlCbF+pUwPN5Wx/WtpAuLO92T+4CUvVmV6ABPhlEOMFkBW//uU7LLZdlxZ/pEzmFt/91GuA==
X-Received: by 2002:a0c:f30c:0:b0:635:f412:6a75 with SMTP id j12-20020a0cf30c000000b00635f4126a75mr4549865qvl.48.1690459436725;
        Thu, 27 Jul 2023 05:03:56 -0700 (PDT)
Received: from nfvsdn-06.redhat.com (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id t1-20020a0ca681000000b006262e5c96d0sm369295qva.129.2023.07.27.05.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 05:03:56 -0700 (PDT)
From: Maryam Tahhan <mtahhan@redhat.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH net-next v2 0/2] tools/net/ynl: enable json configuration
Date: Thu, 27 Jul 2023 08:03:29 -0400
Message-ID: <20230727120353.3020678-1-mtahhan@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use a json configuration file to pass parameters to ynl to allow
for operations on multiple specs in one go. Additionally, check
this new configuration against a schema to validate it in the cli
module before parsing it and passing info to the ynl module.

Example configs would be:

{
    "yaml-specs-path": "/<path-to>/linux/Documentation/netlink/specs",
    "spec-args": {
        "ethtool.yaml": {
            "do": "rings-get",
            "json-params": {
                "header": {
                    "dev-name": "eno1"
                }
            }
        },
       "netdev.yaml": {
            "do": "dev-get",
            "json-params": {
            "ifindex": 3
            }
        }
    }
}

OR

{
    "yaml-specs-path": "/<path-to>/linux/Documentation/netlink/specs",
    "spec-args": {
        "ethtool.yaml": {
            "subscribe": "monitor",
            "sleep": 10
        },
        "netdev.yaml": {
            "subscribe": "mgmt",
            "sleep": 5
        }
    }
}

v2:
- Removed From:... that was preceding the commit description.

Maryam Tahhan (2):
  tools/net/ynl: configuration through json
  tools/net/ynl: validate config against schema

 tools/net/ynl/cli.py            | 135 +++++++++++++++++++++++++++-----
 tools/net/ynl/ynl-config.schema |  72 +++++++++++++++++
 2 files changed, 187 insertions(+), 20 deletions(-)
 create mode 100644 tools/net/ynl/ynl-config.schema

-- 
2.41.0


