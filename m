Return-Path: <netdev+bounces-260067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFpuF6BrnGnrGAQAu9opvQ
	(envelope-from <netdev+bounces-260067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:00:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E0A1785BF
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED5703119302
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8985265629;
	Mon, 23 Feb 2026 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="FtA2Va1m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499B326E6E1
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858568; cv=none; b=S1lG93f0Rsh291HIHHjx4GZlVemwqqJOnXVQAe1sm84/sdAByhZ6XhLqE8LltLQ0gV6lk0QUrpn2faFDY1XqUGbU8jc5gop9y9WlN7id1OrzWL8m/Q+wMtvlnPkWF47cqQlqRqG9O12AoBoQqk8KNtxKYbeW2bwgPynIJnNlah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858568; c=relaxed/simple;
	bh=J7ICLv2Q9/Vdq+1/m3WDOFi6EZzKHXjbiKoCSUVyYaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZZZXNqAmt5ZVKtYWBdgnO+PliTaeXiM95XeOgQEfbHhkzHRu9sIGZ8/cIpun32BMgQGIi8pvuA2RoiRrFztBMxIfCzHkABtmC8NUXZTwUcE5VJlUCGcaLIS/70Ynx9G4ezB9wvMXwnH82ZQ0HqKsWx7m5iTMqwYIzWLkikdapw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=FtA2Va1m; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43638a33157so4141784f8f.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 06:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1771858566; x=1772463366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAx82hnCtMR1ttiFl2Xfb9N2ppLOSAqxIO3GbI4LCTg=;
        b=FtA2Va1mzq5ZKnZ32Mh+1P57d+bsOlqFSV/xZs1CT/iWMJ8oO1l/KrACHl+CnDmkjr
         k6YIiFcRXRn6RPIvFUSHIaPcjgx2+UiKwhdHFcheSe5Jv31s6f56JPoSbEX+4O488uU3
         mPpjC5ggSNvi/p4EM3YYaJ39j9bgVMMexB6szPkqJDnECN0udRfDKB8oKCXq8Gr7qKVv
         15ouSwhftAhcOVsG4d6l0QcP9sFjg5txQOqALHf8jZpvBSS7ILdFapS3a+qGCcOWW3e6
         4U7UbRSm3NFzaYqQUxUvUpxQZnMwH2AoqnLjMvJEHEx9wH86IE05i1dYoNsylfY7EiJI
         Xmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771858566; x=1772463366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dAx82hnCtMR1ttiFl2Xfb9N2ppLOSAqxIO3GbI4LCTg=;
        b=jxVSOva++b6aBig6X4AVI81tT/mKCgeVmMASuyDQMVtYKOaRR8PfppUieDrmKmn1Kh
         6qdcvWDU/gw586rstY0XdagjdHG+f7cCp9wA2cwDEDtZiTjFb42U8bogP0rqRbgxqONt
         qsXMwCAbmvmsYQKsElfDPbzNTzgrWct0k/e+FV/tIcMneBAA9Pf6B0EcMtUrYRoXvxFO
         S4mZWiTwrhNIT4K9tRZtjBX7b0D1XkLyBN4OF9kfV+d8KalnJtb9Tv0oBkZXZ/vuAMe+
         +zojjtbZAmrooqXTJgWd5wOxe55eS3ofmlzHvb/ExO5mz/t2h4PGl70hTxPcLHw04F/g
         u13g==
X-Gm-Message-State: AOJu0YxGc5mIl9JpEua1b4cML76RiwGou4AaazISNJEYF0XjpXQ8XK2v
	dQ6LlYEso1Zfno/Hs9w8Yscml8I/z0rwJfMTDe5dKOAB9YBWYQmhyA4da7JfXwHzpbU2TbjZ0ur
	mqueN
X-Gm-Gg: ATEYQzxhdDfBokEB4sx91X2L28AaPSReLjbThU/zMwieEBjrPla/rFizWI3zry9T9VV
	f4rI1seonh/FG+lFTKX9WrbaMkSM+blqLJNrZXsyYS7YdDBorvQ8kT9/byMNsq9QkyVTNLdCPd8
	UBOcJGxcsOvDMKzCUrInaZXT6WbEykEdEdvNQ4b87WodRgA7pHO6t6oMVl4Ss3wreHZWXUCaAUE
	fXrkD5eFaC+T4HfDWAwlxTuE1TTQb+uuRBE5L96pEJYtRtcFaQrvi7xhQ0c1zr1DOzcjBnmot6u
	oJ9qCo5iLf3vL2346BhA5RWkYbPq3eIqMbCKLUKGtRriDDOwl5i0GFa157RNonKfkKzgGReBV2f
	vPmnSQOiOf2rRPY045dChMY1+QoxEOjRFroQKCmUkT1nI9/1apEUc9xv2o7FvjmG5yyYAE0s7V5
	P/M6qs+jZjxtYknw==
X-Received: by 2002:a05:6000:2dc6:b0:437:6dc8:c372 with SMTP id ffacd0b85a97d-4396f174f23mr16945186f8f.38.1771858565570;
        Mon, 23 Feb 2026 06:56:05 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3fc12sm17461895f8f.24.2026.02.23.06.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:56:05 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	przemyslaw.kitszel@intel.com,
	mschmidt@redhat.com,
	andrew+netdev@lunn.ch,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	cjubran@nvidia.com,
	daniel.zahka@gmail.com,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 05/10] devlink: support index-based lookup via bus_name/dev_name handle
Date: Mon, 23 Feb 2026 15:55:52 +0100
Message-ID: <20260223145557.248679-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260223145557.248679-1-jiri@resnulli.us>
References: <20260223145557.248679-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260067-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7E0A1785BF
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Devlink instances without a backing device use bus_name
"devlink_index" and dev_name set to the decimal index string.
When user space sends this handle, detect the pattern and perform
a direct xarray lookup by index instead of iterating all instances.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/netlink.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index b73cec31089f..127f337489c0 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -200,6 +200,15 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	busname = nla_data(attrs[DEVLINK_ATTR_BUS_NAME]);
 	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
 
+	if (!strcmp(busname, DEVLINK_INDEX_BUS_NAME)) {
+		if (kstrtoul(devname, 10, &index))
+			return ERR_PTR(-EINVAL);
+		devlink = devlinks_xa_lookup_get(net, index);
+		if (!devlink)
+			return ERR_PTR(-ENODEV);
+		goto found;
+	}
+
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
 		if (strcmp(devlink->bus_name, busname) == 0 &&
 		    strcmp(devlink->dev_name, devname) == 0)
-- 
2.51.1


