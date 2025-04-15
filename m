Return-Path: <netdev+bounces-182976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87525A8A7F7
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 780B17AA061
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1150E24EAAF;
	Tue, 15 Apr 2025 19:29:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506A824E4B4;
	Tue, 15 Apr 2025 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744745357; cv=none; b=cCLUzIm3rXggUnFEphNLkhVoPXTnvMjS8wnguZTbqim20BVHXaixO/hMYU+8w2w+Pha9y0P2W7M+9Tu8cD1KZBi43PYVDxqfLM5g4cA2Ht5KLWY9bakkK2sJ0kCcmu849YKZxbsRzPUQyrX0/GwRTgXLUtiZLGjhbuiVjaqFzCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744745357; c=relaxed/simple;
	bh=2bK9fPs1R9AfvlCTLInBKMOYe/zXdGmlrahhJS0gxqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mNS9FnUlEw4Xmp/U+UXXp1tVYLKQjaXLcLy4UcU6XeVhhGyXhkA4Mq1pq1k3tzvbRJSlHgA9Afrlc7n3T2WoiFEVxLvTD9H2AB31bc9RtcIQnBdvICjHsaAKj6++JAekAwfNQs3Hm07oI8HGu1Z4PTyBSZYxDeIXBABJjVIkIOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-acb39c45b4eso3264966b.1;
        Tue, 15 Apr 2025 12:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744745353; x=1745350153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IB+0Pf4ztxh0w6HNNRAsrb3R+cZgfswKfYgmIp/HaMU=;
        b=JNzzPQTuaLNfafHhT+vzW6Pqv6dqez3fy2VQ4U2ASyIPMJNu0PgZ9NtGhGPrAh0cub
         NtdBMRCuQzaPNAjhXNiDUVhWOMadfRrWm2EZEKf/KgwqJdBLzlD2eJA+cR3IeWtULnKJ
         2j7pKXinw7tkC5rn4EdN907+zxKjC3R5Eb0EclzVLfuzj43xztWzqAmxHuF83ZFBFO7K
         xrK0Dcl3dK/NNHSJS/ZwSdqqxLOhZXFADgRc/ks4Yl1qmI+d5R8ixLZhl2LT8vVqM6eA
         jZxzKTZMb3AvaWNpQod1Y3SuVGq6xhopM5vRMNs5t1+onXobhGRNifPqKs5DnlSxOry9
         1ZNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5jaA3Kz68STW8lkqFpQSwQLqsk/ninvx2SZ+q16D+P0AOxBLOr0LWb306Qj8xK0Uito56TpoHET+unuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr/rxZGb+E/Uz/kAuAeD3TYDfyZ519x/gavnqTvOHcigryFUqb
	Ej6GO0ZkxrdEHIYPwWlrQ17opB6uHxDzEh4FTbj8n9jf5fHS79nv
X-Gm-Gg: ASbGncskiXAiCgMOuyrQxj9sBe0XUspV+ddSV+jZtc5GO/pV23tnDIx8ORwf3hywxLB
	J0Zy1eCa98tiTRit9XKleDo+P2slpRLuolw4q260m6vZGtIFXDkyFYBmypBhzUgZAy7F0SgdZqL
	5xNxKzcOGnGDc6sabtZHWPNsfJaTKPJDd8KOMiXIrGCHWlsR+irbiAMHMQdtwqD2Ec/n3UAPAe0
	ZhGcMS4FrPv8neGbP41Qh3OAfUKvknsIYPrTrjF8+RJUAnXKLQfIu+Iu/zAJCYWxgfZvJmqH0Fd
	+l48dxCbHrjoYCVhP6Bna6SQXj/Hml4=
X-Google-Smtp-Source: AGHT+IGhcE7UsZXqgfakxmLRpPE6Hlj6C3GDZvKpkuseFfdxuIwtJXkO13LJUmGb8oW1BRfo9NotCA==
X-Received: by 2002:a17:907:3f15:b0:ac6:f3f5:3aa5 with SMTP id a640c23a62f3a-acb3822aabdmr27669866b.16.1744745353452;
        Tue, 15 Apr 2025 12:29:13 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ce70c1sm1150581966b.175.2025.04.15.12.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 12:29:12 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 15 Apr 2025 12:28:55 -0700
Subject: [PATCH net-next 4/8] ipv4: Use nlmsg_payload in devinet file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-nlmsg_v2-v1-4-a1c75d493fd7@debian.org>
References: <20250415-nlmsg_v2-v1-0-a1c75d493fd7@debian.org>
In-Reply-To: <20250415-nlmsg_v2-v1-0-a1c75d493fd7@debian.org>
To: kuniyu@amazon.com, "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=964; i=leitao@debian.org;
 h=from:subject:message-id; bh=2bK9fPs1R9AfvlCTLInBKMOYe/zXdGmlrahhJS0gxqg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn/rOBkUl3jC0A1kyIEmHRZ/sX0sUnwKnlP0bN7
 MM2W/XiTziJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/6zgQAKCRA1o5Of/Hh3
 bQv+D/9r8CO+tEhmHNxLHy4CMNQK85KFGRq3i/DxiomWkQjNNepMuCWF3OUov1fomBUbYDPKcgC
 Z3YFvsfaXrGOHZXOMEiQxDtClXaPfOiyvH26ATTisQwiOsxDyXH50RLpLfnyByKccM9QZEgmU0H
 znDaqesw/XxI7A2JmUXK8DsL1icvlxrAo1Vqcma5oLmjbZKuY5n1euXkVglvCdi9n7beyk8DAp6
 7qGpkgCONvTRHbMGKmi1SzkuWw3o4u4VhdZfJMZS/JrrW7kZyYrpl4lpV6PLoBkeqfsfEgO7pGY
 g6PIu3IG6BmzjDSkzBYAno3MeUrUahckc/NWMO8L60XFVazu5y4BrNZJTwS7c1P2eMEHD50W3G/
 +aZ9ePsbY+xmYor9d457EWsSUpQYhP2Lx90G2gnFa/w6wGYMh1yYCPwxmEreBgFzmvfSVQY+Yyp
 3578YjjnXbHY5mfN0pc2biVCtcdxoBFHLWHC9nYZjH8mdTuahBXBGg6qADX3+t/xUQWjgXCSrvr
 uqGFWZokLaklnYrc1HdgwYGLIL47HoP8OpuGQhwykJmCYFG0U6OEKMi/20DwYGPCBEfDxtZbdJM
 GbOhqTnqAM1hqX4aiH6GoLwv2ifoSfHwu362H4oiMlHSAiXC78rF+1REQetBiIyzW5RSl7UnzOz
 slIFNKrKOFy7PGw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv4/devinet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 77e5705ac799e..c47d3828d4f65 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1792,12 +1792,12 @@ static int inet_valid_dump_ifaddr_req(const struct nlmsghdr *nlh,
 	struct ifaddrmsg *ifm;
 	int err, i;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*ifm))) {
+	ifm = nlmsg_payload(nlh, sizeof(*ifm));
+	if (!ifm) {
 		NL_SET_ERR_MSG(extack, "ipv4: Invalid header for address dump request");
 		return -EINVAL;
 	}
 
-	ifm = nlmsg_data(nlh);
 	if (ifm->ifa_prefixlen || ifm->ifa_flags || ifm->ifa_scope) {
 		NL_SET_ERR_MSG(extack, "ipv4: Invalid values in header for address dump request");
 		return -EINVAL;

-- 
2.47.1


