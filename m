Return-Path: <netdev+bounces-182209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06567A881C3
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1816F189157E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098442E62A4;
	Mon, 14 Apr 2025 13:24:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CF92E336E;
	Mon, 14 Apr 2025 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637081; cv=none; b=jgn241ViGhEBaZdx+5hTsIWbidMCWGRTa0e1QH76GEDfhSS2UOo00dAiXidJAdDDjKfP9P6fXJZ5ll8zxWVhhdxgqnCfgPDvCAZuPwYNcaCs43dByPD5y0Ttbcr2dLcP78qhmI3wsBxWdS4mjTXjg993UmR6HENfEWocQQL8PO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637081; c=relaxed/simple;
	bh=en1ltXMO9RVI8XlPeqM8dFi0KjiLZRuKlNQuAxNZcOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KIWawIYAlY58J4pYKmp7cSifQQxCzDMK4/uv/v7vmQv1urGiaXCme/cv35ys0dUlaPxXPtpHc3duw/ZavZAnUg2su420DeJdhx/Q8THsIZVbK8uAbBzUtxGgpcng1TobO4TDss9aD8mP4wIkKGdHZe/5ccYKec3XsulyzhmCt60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso828096566b.3;
        Mon, 14 Apr 2025 06:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744637078; x=1745241878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlKFK33sa7P2jc3BqHF+WpGafwhDJ+3yR9vD3sCH0gg=;
        b=UYHf0nJCOLby1IZeq1EUMFPGhoU6v1Tng00YgAuEBbWlSuAuRozhgC4sVx+Gw09lQt
         eyKLemWm2MsDCK4/0S9eZ7qTUXzjWrEEFka+MQVyHZIIEr8tufz3Q0zTDkhdcl8nwEjR
         C1Weqrix3x2Js2k9fKJTEp9RjKtjLc9/EuUyoNABsOmlKqo3RCT7FMtdLRlMpSdEPEhv
         ybm49NR3pdOqpy7dEvFhCcBoneHB8lCGUQHyOhhgEI3l0ccrTS/TxwtAegVrnvLZ8qu/
         3+6qO9j8b3/fYxbW/W/wxoS72nrwqUTTEadL9ziSVnBavZ8Y67W8OkJ+bUKTDRWGdMdD
         A8wA==
X-Forwarded-Encrypted: i=1; AJvYcCX0GUpSXPuMbZDBMI6HDGM5TCJ4oMv9tlm3/N22xvdZU0xe3O2RrZ6337dQCZT9h4R//WeTSOW1t7O7gHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbGnQ1ls06SdUJfWBMiSx9Ivq9kdA9I5LV3k/6yDCOVhdNuHJf
	Zrv/pC9VrG/MtzgiuIyr7v3gH+wLOhYqDnOCKGABuKIAyknz5yQa
X-Gm-Gg: ASbGnctAkU/f/P7pEgB3RCWNIWx+pT1b03YBLnqfwGA+WPWplrN8DqO8NnyMc33xZ5X
	bevjMzgzSVEX++6EeOLvb8L7AG4u17wKDZqRfFVzXayzLiwJct5fWElpJboXLZyYmXJDL4pFQ7Z
	T6gmMkQeiQjZpbOeU20nWmE6p2jXRYJ4TT67FBVzmL95Xs3gDaBMUyQ58DjuMFPo5aYWraYdXBb
	kxlQ/eqjKithIBCnfDKY9H9lxuIh/vyatANR7TOeW4JQAvYwfTDYMdwx2wgvka7GLcQfsE4UcFX
	Qb+uhw9q/zmYVhTLkE5IAFdhGEeyN0AZ
X-Google-Smtp-Source: AGHT+IGlim1qfSoItyCErMnd5JVewMxaT7SNIga4O5+vSR/9onzllsWLwh0YUn5+jMeTxmAE87948g==
X-Received: by 2002:a17:907:3da1:b0:ac8:16fb:7c85 with SMTP id a640c23a62f3a-acad36a5b13mr1256050066b.41.1744637078331;
        Mon, 14 Apr 2025 06:24:38 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be9c0dsm916297566b.61.2025.04.14.06.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 06:24:37 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 14 Apr 2025 06:24:10 -0700
Subject: [PATCH net-next v2 04/10] rtnetlink: Use nlmsg_payload in
 valid_fdb_dump_strict
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-nlmsg-v2-4-3d90cb42c6af@debian.org>
References: <20250414-nlmsg-v2-0-3d90cb42c6af@debian.org>
In-Reply-To: <20250414-nlmsg-v2-0-3d90cb42c6af@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1015; i=leitao@debian.org;
 h=from:subject:message-id; bh=en1ltXMO9RVI8XlPeqM8dFi0KjiLZRuKlNQuAxNZcOE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn/QyO+waCUv4HYcPoIC+bv90HmwDsIMg8/Hyhw
 Kai6JjKWYqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/0MjgAKCRA1o5Of/Hh3
 bUmJD/9KzZ5qUtgcXIVwZVPK5oDkKuKoMGHVGbzIR3TwTuWfpHslkvs5qVNrIU43359gHnyzRto
 /579qTtmQPja+kTGwVDlgh9/SOR0LgWbN6OER11DPg8ysHxFGBb8PxA8HcWYjeMBWeOLX+PBN78
 ZoUlJPHNrgk6HRe80D1JYBSgsDF19IjL5jOMx0d+yqKU7Rv82UxyCOnFXSh2eKO6HLXOuQIe/Sz
 AnfuGESz0ZEuRbRO6nyqT8kKDClHKTKnIR/QbYZRXdvZW0tIuzfvqrfDb2twOZykerWuq/iFN06
 0XFL26QAXnLrkUCelbzWMnU4rAO2Xkq36R8Xkshhz/C7lHSUlAZAi19DBulIs1niSYckXpeZsz8
 mynZBrE5JYyx8aok1BBp25qUnW/sL7Bb1/UvLvGvXe6m1rCTuJ49HtpfcoFdMyMfayD7M7j68Sy
 AD7O5rXdzEHdT88risOmTVRjnUb334rLaOEfiiWbdkpAWMeEzNMCfVv1J7B7NfNl95AKFi7+4FS
 DLC1yLe9wGWBMLjDtI5TqYdHEFG+kriQKSvaCBt6107aAOjL38N5vcj09rvpdvz5kv+cljWLAse
 I8/LaW+RweXZeB76OrCbD55w1BEfh0KK8VYYzvOS41WOF6YrIv/EsUXb7iICIMAZZkOY6pb8mi2
 FHpDdfLWZJHddUg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 39a5b72e861f6..31addd26b5570 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4886,12 +4886,12 @@ static int valid_fdb_dump_strict(const struct nlmsghdr *nlh,
 	struct ndmsg *ndm;
 	int err, i;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*ndm))) {
+	ndm = nlmsg_payload(nlh, sizeof(*ndm));
+	if (!ndm) {
 		NL_SET_ERR_MSG(extack, "Invalid header for fdb dump request");
 		return -EINVAL;
 	}
 
-	ndm = nlmsg_data(nlh);
 	if (ndm->ndm_pad1  || ndm->ndm_pad2  || ndm->ndm_state ||
 	    ndm->ndm_flags || ndm->ndm_type) {
 		NL_SET_ERR_MSG(extack, "Invalid values in header for fdb dump request");

-- 
2.47.1


