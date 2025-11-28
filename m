Return-Path: <netdev+bounces-242582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8812EC924CE
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 15:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C5324E8820
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 14:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F59329C4F;
	Fri, 28 Nov 2025 14:21:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A09F2737F8
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339661; cv=none; b=YAVzlRN5HwzCaKsCCBBH1Jf08IFew20byihZ0OiiDXBiaBHzjSeh1PItgE6JwRKT5wPy6FTD0s+oJQ6dL8CotZOEUEFBGOfdV1RVM8Zv6VvBXsEDpBN3cgS7LZ22U6zX9KdOU0HiAL4fPzg1M7p9TjkbR00J0Nt2x6yAV7DVZrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339661; c=relaxed/simple;
	bh=dn83itIlZUWLQ+U+eA+BuY6G1TrO1GUvpGmFX9B58mE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IO498MsG11UQB1DpNHVi7XFd/MG0yq5bs5F6riQp7k/QehJ+dHZsfRg5ee/Zq3G0M3Jn7sQr5CHLVCMmUzO3KmZxVEzyIk4sIniEE81T2tNgGkAgoalsrqqC1LvVrHcX4R6yBKGxOmhGX/M/5CstkzPgd5uSvid1r2f0OGLLG2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3e83c40e9dfso1126474fac.1
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 06:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764339659; x=1764944459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xVc8Vi5dk8JoHKkvwNwpd9Rz/OBPsAa4UA1kUPWE0N4=;
        b=M/22Wj+s9v0xa6/43ffHEVEZeJj5y8TEWVzW3QqN0kIXEb51Xl9g2fBGElhv8kOupI
         pMGwRqtGjMpitOD+SuBGuwP7WGUCei8CXcK+kaHdPZd6qZd/5Rt0DLZHHB1nuVRJlTX5
         jbmSlNZi/ZB7NcKhS/XnW1ohi2PQUOEoGSeZVAVopomcZNoNAuJnjD6ehHT8MxBSgH8P
         UDsrQxsT/gl5yGSekxQveGpTIE3Mj9YtBHuU3eLvPjNj+Ibn7/ZhsDmyvEdARj2CHPgY
         ttoO6fyjUcVmKQYI9+uKd/mh7eX8NMzX8ulvDdZoFQa3T7hj7hsTvr/RsNyph2+IwGoE
         lcpg==
X-Gm-Message-State: AOJu0Yx/tOeiJOGMQNLZMzRmKPCXKpXKe8xe1WUQv6LBMz16XYNFC+RR
	pzxlM4T8VFA363POGKxfYTgDu/3kreK2R4GhZ15eNJUpI3V7HUMDyIZS
X-Gm-Gg: ASbGnctXc+gzhRt2GsOIZ/L0MM5GOb9HgWDNWqMhdykjsIMvke7YuMIe15OYkF7cZTJ
	PpPIw6Wf2kfMzBWV1kq8sCKWdnlWsT2ILEZgDdg83qihSbsAKTlhfLyCk6fu/SBUTmjHJafpAMv
	IIJplWx+FHxZqjQ6phQaKAVDRgb9rE5K41DWxiZ6KKt/Vs3EN9JSS19zznKsOq/xj1WXKZFhEAk
	6WGkHclWdYvByOe65mEW+xNYtzdLKg58JIgq17dtywqrBY64fGv4STJj2KMLTpz3AvgfsGLee9p
	8pamkmzos1Eo/ViI84703gNbIfIuSu5Yf+s6YsRD6StjDMwvXU74gx0B7yf0nRMu1hpUqUP+s1O
	ByRtNo8/dD9qNv9aFWG+rOeBtHhgg5eFvMBNkyy1Lh3dsxHor9wJLLusnPrG7cs25vuksZagtII
	B5Bi1bRFEz7o8pgw==
X-Google-Smtp-Source: AGHT+IFwD7RpsIfEFgpcmxfYEZy5hKSIijVY3yZmFrgV5YRT+F+kpxQb8bm0YGtDkXzW4eF+67kIXw==
X-Received: by 2002:a05:6808:894c:b0:450:3ff9:f501 with SMTP id 5614622812f47-4511290fd1dmr13040281b6e.7.1764339658257;
        Fri, 28 Nov 2025 06:20:58 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:41::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-659332e1480sm950537eaf.7.2025.11.28.06.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 06:20:57 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 28 Nov 2025 06:20:47 -0800
Subject: [PATCH net-next 2/4] netconsole: Add configfs attribute for direct
 message sending
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-netconsole_send_msg-v1-2-8cca4bbce9bc@debian.org>
References: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
In-Reply-To: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2745; i=leitao@debian.org;
 h=from:subject:message-id; bh=dn83itIlZUWLQ+U+eA+BuY6G1TrO1GUvpGmFX9B58mE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpKa/FqDVOsFZ8329Lx8kfljFJl1ghgku9drY0/
 AXGcDnSjzWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSmvxQAKCRA1o5Of/Hh3
 bRTFD/0Tu3SmDZIjSP/ODQfN9yDeyLXcHnrAF9W8o4lc9Z5qBaMIegPzgfCChdgS4l0zwd2IwHD
 LD3CsR5N+YvzA30Thp+Zu8F7Q2Re3L+6ai1dieyBHutSl/V9LfSLR7WU8GVswYP+d5iETinR3jC
 hhhzf4d98d/0kd6pExSOKwsFlT19wEIH3T2Bad7IWqrnZALyLVQwzfkVEcJW7W0dmiClW+VdYid
 rVdeqld6a7zkqCrdHf6DZsZ/y7YUzgJsNi09EeqT3k+HABD/KQXvRsPKIJK1zSOwsrhhpKwOaFG
 JiDNBwUkmb7wCwPV+GkwkFCyb6jwMMR8qaL85HSE2QuazfTw1rrAFRI9V5kvGjCuvf1zrVcjrOd
 QlIYi8A1zHyl6Zk5dleTIzrdzHLogwj301mKRxgEFMtEBq6BzUBo1GNkIsFW1dAvYmZ8G9vF7+s
 Kdv99GHXtSx3FpdDJi11tcBG9ZVc30lFu9qQJ85JVCPeFteXYbMf9H9zQt/4ern0fmEB2OKDVBb
 JTnjaEZ6LnW6nm06keF2OWv1BTxSoUBIFG0Rss0jMdlOG+8QEsylTV2MqHocI2X3ABuqB0zKF89
 UGyX96WZIHo4WpkIORZgwXMdsOTTXup0GSNZIsuMpsWpS5GsUkk9ejOhT+cc7l/GSWTwAlSL4Z+
 PD3Ybkt+pdrnXMg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a new write-only configfs attribute "send_msg" to netconsole targets
that allows sending arbitrary messages directly through netconsole.

This feature enables users to send custom messages through netconsole
without having to go through the kernel logging infrastructure. Messages
can be sent by simply writing to:
/sys/kernel/config/netconsole/<target>/send_msg

The implementation:
- Checks if the target is enabled before sending
- Verifies the network interface is running
- Handles both basic and extended message formats
- Fragments large messages when needed for basic targets
- Reuses existing send_msg_udp() and send_ext_msg_udp() functions

Unfortunately this patch has two forward declaration, which is not
ideal, but, moving send_msg_udp() functions earlier would cause too many
changes, and this could be done in an idependent patch.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index dc3bd7c9b049..245ed2584bbb 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1194,6 +1194,39 @@ static const struct config_item_type userdata_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+/* Forward declarations */
+static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
+			     int msg_len);
+static void send_msg_udp(struct netconsole_target *nt, const char *msg,
+			 unsigned int len);
+
+static ssize_t send_msg_store(struct config_item *item, const char *buf,
+			      size_t count)
+{
+	struct netconsole_target *nt = to_target(item);
+	ssize_t ret = -EINVAL;
+	unsigned long flags;
+
+	mutex_lock(&dynamic_netconsole_mutex);
+	if (!nt->enabled)
+		goto out;
+
+	if (!netif_running(nt->np.dev))
+		goto out;
+
+	spin_lock_irqsave(&target_list_lock, flags);
+	if (nt->extended)
+		send_ext_msg_udp(nt, buf, count);
+	else
+		send_msg_udp(nt, buf, count);
+	spin_unlock_irqrestore(&target_list_lock, flags);
+
+	ret = count;
+out:
+	mutex_unlock(&dynamic_netconsole_mutex);
+
+	return ret;
+}
 CONFIGFS_ATTR(, enabled);
 CONFIGFS_ATTR(, extended);
 CONFIGFS_ATTR(, dev_name);
@@ -1205,6 +1238,7 @@ CONFIGFS_ATTR_RO(, local_mac);
 CONFIGFS_ATTR(, remote_mac);
 CONFIGFS_ATTR(, release);
 CONFIGFS_ATTR_RO(, transmit_errors);
+CONFIGFS_ATTR_WO(, send_msg);
 
 static struct configfs_attribute *netconsole_target_attrs[] = {
 	&attr_enabled,
@@ -1218,6 +1252,7 @@ static struct configfs_attribute *netconsole_target_attrs[] = {
 	&attr_local_mac,
 	&attr_remote_mac,
 	&attr_transmit_errors,
+	&attr_send_msg,
 	NULL,
 };
 

-- 
2.47.3


