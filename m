Return-Path: <netdev+bounces-23739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AA576D567
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E787F1C213AF
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2764134B6;
	Wed,  2 Aug 2023 17:28:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9730713AF1
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 17:28:02 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACDF3A9F
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 10:27:36 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe167d4a18so1191215e9.0
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 10:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1690997253; x=1691602053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5ELzyVk/XA1aCrZBrMuYOfiLZ2aUjuTj3gKgPsL214=;
        b=VeF8NquyO/p8eu707GC3eeuT3FhjPxlFNBsZOLoqNk8jLkUffJ1tsfYmp+ow/lHf7K
         ESahpK8ztx8ZlrCe9s4869mbyBq+SP46GwwWLoIRA8hIRCtPcs97CtumxnFkRWf8BxqU
         FQzZeUS6FDAt/y7NS4VNFsJC0Odn3lfmnnu1N/lfA2AXhAps67PUpSp4q0/R3zTCfi/S
         HUw3yG8dcmFnwqURZZKObjty6tDJtxQUajjalgIlar0kec92Z4TKVUvlX5I7uA3ZzqqP
         3sVZjUfRolQbaikcdAMJ0spIaUgW/09G7i4ZvbZJSOGaRxc/pjk8Gb6fbUwWjKzdRa7y
         B9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690997253; x=1691602053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5ELzyVk/XA1aCrZBrMuYOfiLZ2aUjuTj3gKgPsL214=;
        b=Yf9YQ4bNkJKfM6yMTvfGBAdLMpuhCQo5UYtvAq3V74TV3BX2oDfn0ZhvZyG6pMfpvX
         7NkQ9Op2qYi6AUeUjDSMJ5fHBpvOQrGeiC8LkzNU8SSB6YVeN+ve3Z6XGqQrgJM7DlFv
         Nfkvv3NpNOmSeLMW4qhsjG0MVHkwCRme7p+WZxUjlGF1LV62Onz3KiTUbQy4zt+CCRuj
         lg8/EYxqXQpeZQLTm5aZL0NwmyMqP6lUyF9BrjafVtqJ2XEFHbHdEocdU1DjRCC5VOum
         B8gkX+GMuxR1uaNRzrVyn3t65cggFSQaD+qeNrnxp3NPPF8AmQCCnXAK7O1QCTq6KPnN
         PbUw==
X-Gm-Message-State: ABy/qLYYbD+6Ph3+jghn+BgbjoNQ4kRLF+fswwJSaiDO5CNZ7KzIXzcp
	kfxv/kgctx4TotfZvGYjqlK8tA==
X-Google-Smtp-Source: APBJJlH5idCr0u7kYS3Xt1Nc/PAEGp2DegQ+cidms0fu0pk2dg+dO+E4dnbR0Y0MkSuXQFOlST5uLQ==
X-Received: by 2002:a1c:f202:0:b0:3fa:97b3:7ce0 with SMTP id s2-20020a1cf202000000b003fa97b37ce0mr5160054wmc.26.1690997253630;
        Wed, 02 Aug 2023 10:27:33 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id q5-20020a1ce905000000b003fbc0a49b57sm2221770wmc.6.2023.08.02.10.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:27:33 -0700 (PDT)
From: Dmitry Safonov <dima@arista.com>
To: David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	Dmitry Safonov <dima@arista.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Ard Biesheuvel <ardb@kernel.org>,
	Bob Gilligan <gilligan@arista.com>,
	Dan Carpenter <error27@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Donald Cassidy <dcassidy@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Francesco Ruggeri <fruggeri05@gmail.com>,
	"Gaillardetz, Dominik" <dgaillar@ciena.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Ivan Delalande <colona@arista.com>,
	Leonard Crestez <cdleonard@gmail.com>,
	Salam Noureddine <noureddine@arista.com>,
	"Tetreault, Francois" <ftetreau@ciena.com>,
	netdev@vger.kernel.org
Subject: [PATCH v9 net-next 17/23] net/tcp: Add option for TCP-AO to (not) hash header
Date: Wed,  2 Aug 2023 18:26:44 +0100
Message-ID: <20230802172654.1467777-18-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802172654.1467777-1-dima@arista.com>
References: <20230802172654.1467777-1-dima@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Provide setsockopt() key flag that makes TCP-AO exclude hashing TCP
header for peers that match the key. This is needed for interraction
with middleboxes that may change TCP options, see RFC5925 (9.2).

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/uapi/linux/tcp.h | 5 +++++
 net/ipv4/tcp_ao.c        | 8 +++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index ca7ed18ce67b..3275ade3293a 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -354,6 +354,11 @@ struct tcp_diag_md5sig {
 #define TCP_AO_MAXKEYLEN	80
 
 #define TCP_AO_KEYF_IFINDEX	(1 << 0)	/* L3 ifindex for VRF */
+#define TCP_AO_KEYF_EXCLUDE_OPT	(1 << 1)	/* "Indicates whether TCP
+						 *  options other than TCP-AO
+						 *  are included in the MAC
+						 *  calculation"
+						 */
 
 struct tcp_ao_add { /* setsockopt(TCP_AO_ADD_KEY) */
 	struct __kernel_sockaddr_storage addr;	/* peer's address for the key */
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 236c8cd1a0c7..0d10b437b0f9 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -565,7 +565,8 @@ int tcp_ao_hash_hdr(unsigned short int family, char *ao_hash,
 		WARN_ON_ONCE(1);
 		goto clear_hash;
 	}
-	if (tcp_ao_hash_header(&hp, th, false,
+	if (tcp_ao_hash_header(&hp, th,
+			       !!(key->keyflags & TCP_AO_KEYF_EXCLUDE_OPT),
 			       ao_hash, hash_offset, tcp_ao_maclen(key)))
 		goto clear_hash;
 	ahash_request_set_crypt(hp.req, NULL, hash_buf, 0);
@@ -613,7 +614,8 @@ int tcp_ao_hash_skb(unsigned short int family,
 		goto clear_hash;
 	if (tcp_ao_hash_pseudoheader(family, sk, skb, &hp, skb->len))
 		goto clear_hash;
-	if (tcp_ao_hash_header(&hp, th, false,
+	if (tcp_ao_hash_header(&hp, th,
+			       !!(key->keyflags & TCP_AO_KEYF_EXCLUDE_OPT),
 			       ao_hash, hash_offset, tcp_ao_maclen(key)))
 		goto clear_hash;
 	if (tcp_sigpool_hash_skb_data(&hp, skb, th->doff << 2))
@@ -1407,7 +1409,7 @@ static struct tcp_ao_info *setsockopt_ao_info(struct sock *sk)
 	return ERR_PTR(-ESOCKTNOSUPPORT);
 }
 
-#define TCP_AO_KEYF_ALL		(0)
+#define TCP_AO_KEYF_ALL		(TCP_AO_KEYF_EXCLUDE_OPT)
 
 static struct tcp_ao_key *tcp_ao_key_alloc(struct sock *sk,
 					   struct tcp_ao_add *cmd)
-- 
2.41.0


