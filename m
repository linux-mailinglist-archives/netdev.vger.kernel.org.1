Return-Path: <netdev+bounces-44632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AF37D8D4A
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 05:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C901B2129B
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 03:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C7F64A;
	Fri, 27 Oct 2023 03:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdDYMYgK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D836717FA
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:03:20 +0000 (UTC)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4653F129;
	Thu, 26 Oct 2023 20:03:19 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1cac20789e8so3053345ad.1;
        Thu, 26 Oct 2023 20:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698375799; x=1698980599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6EOx1Hx1IAPQ1YOKRVGNCkYTk+hHI63wiG6ySEOWqsw=;
        b=OdDYMYgKyBVpQnrS24hArShy7Z1Tdd/bRseMd7hFzVqMBeA/sCMpA/gckgYsEFDYii
         s+MvtgRbrdfQAvkHhWDTFkFhCZ2xmQRtav0ZPvYvpFBkjbrx++Bp/TV/tJ78ZpYS88q7
         mEwrak+CHMylQlNQwMRE1UvzZ4X+7SdmjBFNtCToI4LdNpTv/dcK+Izo5BYI19U+DgvW
         3F+rOSJsX9r/Rbk/AraogAWi36gonPTHsUZzxL4dwrbe3TpuV2cYwJqNOSHv8kf/CyOg
         ck9sTDxEMS6OF//+TZWi4/IBfUMNjeMs24iKst/FnQxLfuzCRttevFeMavdFDZ6cMDU2
         NhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698375799; x=1698980599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EOx1Hx1IAPQ1YOKRVGNCkYTk+hHI63wiG6ySEOWqsw=;
        b=ev+AhFppn353sy+hqiVW3Ay60eB8vhnbY988TEiTVgw3BFd4cYaXb8eWZctqrtxR5B
         VlTFlmNUmQ7hDnlGomsREmMFzREO0M2U8xdLr7zVAXcf+hLCaTp2WpEoc3VDBnYOj/ee
         JxROpE6OBo2nQqzmfwFghH/l0aYEFIYPbuj4IUaar7KzSc0Zud3upRHaUzlk9WXnAeQa
         zAEupiyH2UJBL1zGdb/2VtBCxXhMAUmS+Ij8hhtS9ON/L69ex1s88bFMRn47jXGn4OFq
         fiueyFVuJZwvMJ8z0rGXgMcg30oRgLtAkxvNDgSjW9LjbDW1XpX/39zebNS5E+HN1Ifv
         q8Rw==
X-Gm-Message-State: AOJu0YzzVpA70jJGEoq4pOwOeSwdY5eOmqc3zOvaNFISN/rp/yv8DRVs
	edrRuxhx7V0ijGFTahbDm18=
X-Google-Smtp-Source: AGHT+IG9yKdbB5f6crmqx99aYXu0CfVPTX0c780HCd5N35eViHlFac5rHuZEhQhsRoxb4hn+gVW6SA==
X-Received: by 2002:a17:902:f213:b0:1c4:1cd3:8062 with SMTP id m19-20020a170902f21300b001c41cd38062mr1465649plc.2.1698375798663;
        Thu, 26 Oct 2023 20:03:18 -0700 (PDT)
Received: from hbh25y.mshome.net (059149129201.ctinets.com. [59.149.129.201])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b001bde65894c8sm407508plb.268.2023.10.26.20.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 20:03:18 -0700 (PDT)
From: Hangyu Hua <hbh25y@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2] net: 9p: fix possible memory leak in p9_check_errors()
Date: Fri, 27 Oct 2023 11:03:02 +0800
Message-Id: <20231027030302.11927-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When p9pdu_readf() is called with "s?d" attribute, it allocates a pointer
that will store a string. But when p9pdu_readf() fails while handling "d"
then this pointer will not be freed in p9_check_errors().

Fixes: 51a87c552dfd ("9p: rework client code to use new protocol support functions")
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
	
	v2: change the Fixes tag and remove "ename != NULL"

 net/9p/client.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 86bbc7147fc1..b0e7cb7e1a54 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -540,12 +540,14 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
 		return 0;
 
 	if (!p9_is_proto_dotl(c)) {
-		char *ename;
+		char *ename = NULL;
 
 		err = p9pdu_readf(&req->rc, c->proto_version, "s?d",
 				  &ename, &ecode);
-		if (err)
+		if (err) {
+			kfree(ename);
 			goto out_err;
+		}
 
 		if (p9_is_proto_dotu(c) && ecode < 512)
 			err = -ecode;
-- 
2.34.1


