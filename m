Return-Path: <netdev+bounces-49940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50497F3FEE
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 09:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FF56B20E48
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 08:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369F52207D;
	Wed, 22 Nov 2023 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="E3cta5dn"
X-Original-To: netdev@vger.kernel.org
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70072D62;
	Wed, 22 Nov 2023 00:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/fB6eIZmKADlx9vmc7Mv1MvPBKVxtn07LHNUeWpfWWc=; b=E3cta5dn9d1WrfPbb+Hndx4N1r
	nuU3JUcFGuqHkH8JNDR24YWXdgVr1S+yBiAHby0aAZTFmf4sK4Ff2LBoYOMTA3bDFppkoDl3QXNfs
	fMwLRV/DWzIrNgH8QiZDB7HtbKpVY51x57a16n8VBEVnUGYnRjp8MxhfkuyT4uJhYlSjTg20lsqVN
	5MIiTYbdK0IiC6qM8GuqzbiDo03cWqAPQsEtnH1XwtlV263zrmT46K63aH1tir/oE9EsmbhsWtiRO
	QQYiRmk7sT53vZ+WDIUWLHxwpVgRPci35xkJWFQsnH9a06wbHNn9AVVACLX9DC38fC+D6HYH2+2t8
	/gIhQ6/Q==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1r5iMH-004AEH-TG; Wed, 22 Nov 2023 08:13:18 +0000
Received: from ben by rainbowdash with local (Exim 4.97)
	(envelope-from <ben@rainbowdash>)
	id 1r5iMH-00000000boe-42Oz;
	Wed, 22 Nov 2023 08:13:17 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] bpf: declare bpf_sk_storage_get_cg_sock_proto
Date: Wed, 22 Nov 2023 08:13:17 +0000
Message-Id: <20231122081317.145355-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The bpf_sk_storage_get_cg_sock_proto struct is exported from
net/core/bpf_sk_storage.c but is not decalred in any header
file. Fix the following sparse warning by adding it to the
include/net/bpf_sk_storage.h header:

net/core/bpf_sk_storage.c:334:29: warning: symbol 'bpf_sk_storage_get_cg_sock_proto' was not declared. Should it be static

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 include/net/bpf_sk_storage.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.h
index 2926f1f00d65..043155810822 100644
--- a/include/net/bpf_sk_storage.h
+++ b/include/net/bpf_sk_storage.h
@@ -22,6 +22,7 @@ extern const struct bpf_func_proto bpf_sk_storage_get_proto;
 extern const struct bpf_func_proto bpf_sk_storage_delete_proto;
 extern const struct bpf_func_proto bpf_sk_storage_get_tracing_proto;
 extern const struct bpf_func_proto bpf_sk_storage_delete_tracing_proto;
+extern const struct bpf_func_proto bpf_sk_storage_get_cg_sock_proto;
 
 struct bpf_local_storage_elem;
 struct bpf_sk_storage_diag;
-- 
2.37.2.352.g3c44437643


