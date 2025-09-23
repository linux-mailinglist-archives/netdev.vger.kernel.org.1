Return-Path: <netdev+bounces-225721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C484B9784D
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 22:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25037B399F
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 20:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E23130ACF5;
	Tue, 23 Sep 2025 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUucddk7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56FE2561D9;
	Tue, 23 Sep 2025 20:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758660323; cv=none; b=A+uA21bPabQ/2863M+rKMwOE5+EOlThGfTpV9qGEZvfq7uAHcUBMhnZWy4FRl44NQaRmAEmNz5gnm9QGz7fGczioDV354Lk8K7gkZRmrSQmaCUnd2fA0Tn4lwU+LK2w75P7KoE7LKGz0ND5zOtL7sQOmGZkK8cruLNRHOLQ+ldw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758660323; c=relaxed/simple;
	bh=rvjOj88P6+x6qxE5cFZzBWFWooanWxpbJWxaiAu/qZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EHKPJ3TRcRBigHE0Ht5f00vrjRRHBYg/6IfEsnJ9mycQ4N68AxAHVsm+4yEl+6rty6F6qTFxQiKVjg8/v388F4yIs23IJNmSN767MTomjeTANXn89NOj41EfDIi2MdKI+j5EYKb9g/m/QAzE33SIXWMY0Fg6K0VttwRqjCo8R58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUucddk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A49C4CEF5;
	Tue, 23 Sep 2025 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758660322;
	bh=rvjOj88P6+x6qxE5cFZzBWFWooanWxpbJWxaiAu/qZk=;
	h=Date:From:To:Cc:Subject:From;
	b=HUucddk77m46pdgDq0PgqoBx8JxFOondK08zeHl2AiKOygiM8DihqR3oNfKt4Nq1x
	 6icxltGB1LQ4T+EC0UXbhGMN3uReIHlQSJRM345IOub+cIMNhHcsSbMLMgmnbLITxL
	 KfnIvFuh8qNmAd+y2HlhzzwpCMg9WYrcf2sgcEhFLjq4KpK5W2z3gep44z9yQLUpaC
	 eDzzSZNdpBGecTroVN8e9AC94XzJD0om6G0maPZKB8S+nsy7JNP3w/z6PoeO/1hXxl
	 yXwREe8ysowvXyoUYjUm3UjqM75UGN5faWVWbUX9iBrhZO6rHbeHjQDwrlXR5eJtsy
	 tf/Vb7FrkUh5g==
Date: Tue, 23 Sep 2025 22:45:10 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] tls: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <aNMG1lyXw4XEAVaE@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove unused flexible-array member in struct tls_rec and, with this,
fix the following warning:

net/tls/tls.h:131:29: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Also, add a comment to prevent people from adding any members
after struct aead_request, which is a flexible structure --this is
a structure that ends in a flexible-array member.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Remove unused flex array. (Sabrina Dubroca).
 - Update changelog text.

v1:
 - Link: https://lore.kernel.org/linux-hardening/aNFfmBLEoDSBSLJe@kspp/

 net/tls/tls.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 4e077068e6d9..06d462c57284 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -128,8 +128,9 @@ struct tls_rec {
 
 	char aad_space[TLS_AAD_SPACE_SIZE];
 	u8 iv_data[TLS_MAX_IV_SIZE];
+
+	/* Must be last --ends in a flexible-array member. */
 	struct aead_request aead_req;
-	u8 aead_req_ctx[];
 };
 
 int __net_init tls_proc_init(struct net *net);
-- 
2.43.0


