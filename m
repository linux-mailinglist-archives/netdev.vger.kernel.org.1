Return-Path: <netdev+bounces-37032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 751217B33FD
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 15:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A7834283D23
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 13:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E964122A;
	Fri, 29 Sep 2023 13:47:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB0FBE4F
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 13:47:54 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83E9DB
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 06:47:50 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-530fa34ab80so1535971a12.0
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 06:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695995269; x=1696600069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EIf4la/I8Qsb0HKDrhvyHC0R4I00Z7if5k71vTFXOk=;
        b=jBFZ6u3RPHx21928CyitrWWonx5bhMbVLdlF9ExNuXfqGde9PbfSWKj0mJdlhKzqSp
         nwFe+NXTa6id5YeM6uIJlLQAaE/kWPUCciyTLdRhXhK+Q/+b72Wy0a45/pL9Y8Ons0Um
         WrNXIEyZWR8U5zhgitACsz+9omIGliKpHZsptN0zDOxITNQbviXJuTCiVkuf6Dx9BTYA
         S+6ggoZLtdCvCsonsYfZNjmD+8TwVbUkSUgVWz87OYPTlzkNEB4qi5kRpQG6CjkzAcNt
         EISB36/y7KGzXAoz9Z+Eo8BztLOap7NhII6xjHHy+DEl8wYMUEw/VoEqbwqzACGkHrQ7
         XVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695995269; x=1696600069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EIf4la/I8Qsb0HKDrhvyHC0R4I00Z7if5k71vTFXOk=;
        b=cgl+4z58EDG3aU1zduzgwTwgZY+g/uyp1CHkx8P3gexf+TxNbpyc4e7E4KDmvyQQRu
         sy2Io4UN/yzyMKaRTn0uC2PNxDSo8lg9Kpz0Sl7eRS6KXwwpbWSU4mTh/4yI/YlW1FqO
         0kYjl96gVNN0IZKGuybTJKaeYVZXUAeoQmk1E18XWGbg98KE3IwQirmiJEqib8o/nMJ3
         BBhC4EnBJikio8l8kB84fNvG7xVLdG/FAQTAFDPsHCGsmf+xbJVU5IZdixICl2kZB7MA
         8pwOeOe916Z3iUCNuEH2ljXlZhv9s2f9HgcYGwJYyg1FZCLH9mx5PCAa3FBGa4IWSpl4
         ELuw==
X-Gm-Message-State: AOJu0YzPyWPRpP3D9LObRyl/dxfQ8Gu8Rcqe/n5uvBfc2WYB0tSOmDAl
	JzJS7Vu9ge93SSDl7+1mWgEJoTt2UPLOkFT6TrE=
X-Google-Smtp-Source: AGHT+IHscpHyUMU/oVJFsXY/5WErByqNKo4OyNE4Za6MmVDk173Ykg0k9+cWZwyyn6iQ7MHjfZ7z+g==
X-Received: by 2002:a17:907:75c4:b0:9ae:6196:5094 with SMTP id jl4-20020a17090775c400b009ae61965094mr4051569ejc.30.1695995269370;
        Fri, 29 Sep 2023 06:47:49 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id rv2-20020a17090710c200b0099315454e76sm12447535ejb.211.2023.09.29.06.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 06:47:48 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	donald.hunter@gmail.com
Subject: [patch net-next v2 3/3] tools: ynl-gen: raise exception when subset attribute contains more than "name" key
Date: Fri, 29 Sep 2023 15:47:42 +0200
Message-ID: <20230929134742.1292632-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929134742.1292632-1-jiri@resnulli.us>
References: <20230929134742.1292632-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

The only key used in the elem dictionary is "name" to lookup the real
attribute of a set. Raise exception in case there are other keys
present.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 tools/net/ynl/lib/nlspec.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index 37bcb4d8b37b..12e15ac70309 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -208,6 +208,8 @@ class SpecAttrSet(SpecElement):
                 attr = real_set[elem['name']]
                 self.attrs[attr.name] = attr
                 self.attrs_by_val[attr.value] = attr
+                if (len(elem.keys()) > 1):
+                    raise Exception(f"Subset attribute '{elem['name']}' contains other keys")
 
     def new_attr(self, elem, value):
         return SpecAttr(self.family, self, elem, value)
-- 
2.41.0


