Return-Path: <netdev+bounces-209431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4840B0F8EF
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5EE5689A0
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F0A22A1D4;
	Wed, 23 Jul 2025 17:21:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645A1225A37;
	Wed, 23 Jul 2025 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291266; cv=none; b=a9XGDICdvxUfFiviYWvTyMvuKVtF7pDAXPxErobxfaSp7TN4lUPLDKz/75i32pXJbjja7uRK4TQNNFXJaJNgGw9wD/Uk8fTbFjcduwhzqaq3lMD2n2eGD2WxBk5ZB06/UXA2PU/jz+p7YrI3Ok6q0cm4NfUlZQ3Ynr/WNP6VgNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291266; c=relaxed/simple;
	bh=PKuplVShqQgUiUiYmqCsm0Ep2rLtTzG/Uy2yvfQ69Yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AeGkkspLW6f5oVdSp22nzaJOtpzY/Udx0KMwVofz9Lj31SHH5quVU2UXNDEekL/0YbK6Gx497blxKw/IGQ5uVSs2NG9doV+0qXtbkvChK4bZZ7rulONlsE6CeZgCxseD/IJ/5G1IC6w8MbA26sNWlrd0YAJQbqGY014pMlrGYsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aef575ad59eso10851766b.2;
        Wed, 23 Jul 2025 10:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753291262; x=1753896062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1uCm8jNm69saJYHGnelConPUrdm7lb5x3hDmLAwVeg=;
        b=HBAPsrlKjR3oPp/raQXvrHjGGaOjOoSHx52TeEifnNVnj3fFsRQ3aLROnSwQauuoUp
         OuVxt36xf3raPmsUm7CNsu1ZeHVOA3bRw67vOXZ8uMNMS68s28dhEO8rbZQTmSHG20N1
         LYkDdnWCtjdHUkuLwRvglv45KEJ8K8rsWCFy2FN3FxyP0zDmsI3fvu3C1vyWINWSl6uC
         nQ7Ex9ZLWgc8m7YaCi6xtYz/jPT8pWo4gfZpZhA/bA8bRunojGPtKCkJWGb1lO+AIjc6
         5V3IAkSi/wmqekTffA/xiUa3D0ZCW763Fi6xL+37nWT356P77wrZhlHpLsDGgk8quVyY
         I3OA==
X-Forwarded-Encrypted: i=1; AJvYcCWDKJtlTl06lYwF2YslJwz7EKr2+JW18DAph4fnmLnuAYBJyVSsTotCkdnOv4vtQMP+b6QI0rughOZJV4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKkN5qhpwr1TxXgd1SlHcVnvElbH3WRP/0m/eqlcD/NDkx1sJ9
	5Hvr6rzvpItR9ufsgNIwMmxcVJ7UTqmJQrMx0fhtKtwZKKhOzja1TK5E
X-Gm-Gg: ASbGnctZ36w4h6N5g++TlN133YR0i+uk98i9q306ybrhn89wScp3/nlDFsWVaj6X3lP
	ijk7JkVfvgU67AIRCRUIdrzc7x3DJ3JoZrH70HL/ZxyvWyIEFB8v9Yt7xZ++9nCl/4mfrkeEXBE
	uEjjswB74QmRAbn6HhFRu04gOHjI+fmfpRzs9c1ru4V7qcak5fFVolCeCPlKsaxpCOUlg7svSp1
	dN//D/bUK8ZAgo9dzxrw/1HADC047Lq1dvlax5Fwq3qM4uxlTn9J4P6eW6g80+2lRb7KQJCvQvQ
	TqYrDA5nP+GGpTuqwheUubO5w4nkqE1BXIrCOsMWZQNpHk7CgKNRVm6tyZI+rFS2QR6dn6VIRia
	WAWvbV4GsEvXr
X-Google-Smtp-Source: AGHT+IGfM+1p2Dvzf4NOq56w14dkXsry5rausath6PXKeZSndp1DlN8/hN0oeWHCZU2OYcovwVY/1Q==
X-Received: by 2002:a17:907:3d16:b0:aec:5a71:4513 with SMTP id a640c23a62f3a-af2f66c2081mr435303866b.4.1753291262299;
        Wed, 23 Jul 2025 10:21:02 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c3d9178sm1073645366b.0.2025.07.23.10.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:21:01 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 23 Jul 2025 10:20:32 -0700
Subject: [PATCH net-next v3 4/5] netconsole: use netpoll_parse_ip_addr in
 local_ip_store
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-netconsole_ref-v3-4-8be9b24e4a99@debian.org>
References: <20250723-netconsole_ref-v3-0-8be9b24e4a99@debian.org>
In-Reply-To: <20250723-netconsole_ref-v3-0-8be9b24e4a99@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683; i=leitao@debian.org;
 h=from:subject:message-id; bh=PKuplVShqQgUiUiYmqCsm0Ep2rLtTzG/Uy2yvfQ69Yk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBogRn3JP1kA19ixcPt9z7HZXtLrfdqVZWu7b0re
 kFBP8gAdnGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaIEZ9wAKCRA1o5Of/Hh3
 bWWeEACwH6eVuy3tbCT0c81t8Ju2pGeTebpHJHCwdvYLMCwCNgq5BEKW9AgLhuhdFIw1XfKmTW9
 mdTqF/63W0+iC7uBkOnXx93RxJsFF8/VLfHo6eQuQqEQccdGhSURKfkabhnE9WL6Ro2BLbyz+fg
 20H1Hrv5hkL6K6EyBSPWeDWV3i61I+UGcUe3dB02kBw0Lwp1ie2Htbdtq4PmrYP7Up4Ky84ldhh
 CYXWtXncrTI+7UFLdLl8vutt7aiuFpn6RJnT22rOEDy/pe26wkt+UiNllqspKkKZsez7k37nlHs
 3gxQZlikFU3bc6SjNqGdAzvwjNDjixMS+pmZ3cLkIAUQg4Flh5DNIUBKSD9ZwYmlzOBjdM7wulh
 cgThFz7kRx60onGxPfbe7j7U9ECeMIVoOAAccTqrN8fsAcC02L/211qw6U2vf4UFQmVcD1qwv07
 BalA9AOfB5OumZWtzz4i/Sl8cgZA2Rq7dy/MqfsD2wMwwnrE5hSH7GmsnaxmiTYC/Mrgo27bCs9
 AYMiUn1Q4Wh3tPvbTHhTqw832cffQUyKfvAcmiMBlCfqJy/C2toJszyqKwlt5iSZfZMjeke7YH0
 aXBVyBZg7F8UAwjuRd1YYDrlhYHDPGuw3gMBoHVhRo5nmEd/W63vsCsYyjokBCly1MS+249m1xR
 NY8NHnMhT+YYV9Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace manual IP address parsing with a call to netpoll_parse_ip_addr
in local_ip_store(), simplifying the code and reducing the chance of
errors.

Also, remove the pr_err() if the user enters an invalid value in
configfs entries. pr_err() is not the best way to alert user that the
configuration is invalid.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 3188cc180a934..358db590a5046 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -750,6 +750,7 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 {
 	struct netconsole_target *nt = to_target(item);
 	ssize_t ret = -EINVAL;
+	int ipv6;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
@@ -758,23 +759,10 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	}
 
-	if (strnchr(buf, count, ':')) {
-		const char *end;
-
-		if (in6_pton(buf, count, nt->np.local_ip.in6.s6_addr, -1, &end) > 0) {
-			if (*end && *end != '\n') {
-				pr_err("invalid IPv6 address at: <%c>\n", *end);
-				goto out_unlock;
-			}
-			nt->np.ipv6 = true;
-		} else
-			goto out_unlock;
-	} else {
-		if (!nt->np.ipv6)
-			nt->np.local_ip.ip = in_aton(buf);
-		else
-			goto out_unlock;
-	}
+	ipv6 = netpoll_parse_ip_addr(buf, &nt->np.local_ip);
+	if (ipv6 == -1)
+		goto out_unlock;
+	nt->np.ipv6 = !!ipv6;
 
 	ret = strnlen(buf, count);
 out_unlock:

-- 
2.47.1


