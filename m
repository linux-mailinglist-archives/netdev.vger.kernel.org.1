Return-Path: <netdev+bounces-44706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4B77D94E8
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302BF1F2354E
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9041803C;
	Fri, 27 Oct 2023 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="x0EzoOrX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E60179A5
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:14:15 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AA81BC
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:14:11 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9c603e2354fso385534366b.1
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698401650; x=1699006450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTqhdD/yxa3vJkiQbvPLc+KLXqkT95pVduQu/oE9MT0=;
        b=x0EzoOrXM1BoRQ2fUHGHfl0gJW3CwmoDKR3paQWwWl/2/qLKPaD8Od9TRqfXUUdRNl
         YMOX9VDKT5W3h+Dcdp8SV50N1eiaOnNH1HyrX/fhbcN/IBSXHTpg9o4423KurdPSOBJF
         7z2GoRXMOainu89vVKlKJHnPIrH0zqHIF4VQf42Nzgp2mrD6oci5uxhDo/dahibBCxbB
         6rmQrx9oEV/yG7hKDkFfjoW+gUQuhS5zvHwLcDC4dxvfrsvd3ZW8d82z45Qbvslq0VUY
         7whwy5unilA1u2ZiLu4s2P4VqOqPbv3Eg+/wnTT18KgHT7Bztcpz/Uy6QXtWd2hj7VOm
         ap5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698401650; x=1699006450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTqhdD/yxa3vJkiQbvPLc+KLXqkT95pVduQu/oE9MT0=;
        b=Zw0oikbt2jKNUBtsDhT/Eqg1q0fmS1MHXZaSBpzJjeDVzocl+tNnJ/sG7lN5iDLtiA
         4ppGqjZ/llpgCtyNxyoMeH1+QLTjvESKbhInp2MrkNiAjjgvH5j+dnovYNnxNuR9I9Hp
         AtrmpZRIGj9HIIUm0RfhNJIggGgrbiqrZUMGKaJVRD0rl7VqTDeIXYvoQ6/slc+7/pt+
         78kVobTamIJaV8RaWMPOzsyOdbPOh+CNq00Q9/NFIrtvMr40LK/olbriaYR5Rg6q+pRN
         DMFNoYPWHcASJBff7bjKGYb8DCTtVT7i04mEDFScn7zuzpad3FBlEtvNmA3HdYjWXj4R
         hnEA==
X-Gm-Message-State: AOJu0YwERHze11CzWKutjk1f+oUZMJAXNH7YSp3rNWU/ymSzpffJdw8l
	ELTfBU44R5zFFpWhcp0EtHJ1sslrwa+vxCLfvDfaTQ==
X-Google-Smtp-Source: AGHT+IFXdSj8hsRoPw8/121dCNEMZXzJHnHtoEM9VT58iVsNRCpRZiFdSVnm13wTVYoMTlfQYbAo3Q==
X-Received: by 2002:a17:907:9403:b0:9be:85c9:43f1 with SMTP id dk3-20020a170907940300b009be85c943f1mr1840016ejc.7.1698401649888;
        Fri, 27 Oct 2023 03:14:09 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id s9-20020a170906a18900b009ae6a6451fdsm963320ejy.35.2023.10.27.03.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 03:14:09 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch net-next v4 2/7] devlink: use snprintf instead of sprintf
Date: Fri, 27 Oct 2023 12:13:58 +0200
Message-ID: <20231027101403.958745-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027101403.958745-1-jiri@resnulli.us>
References: <20231027101403.958745-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Use snprintf instead of sprintf to ensure only valid memory is printed
to and the output string is properly terminated.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v3->v4:
- new patch
---
 devlink/devlink.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 3baad355759e..b711e92caaba 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -2761,8 +2761,9 @@ static void pr_out_nested_handle(struct nlattr *nla_nested_dl)
 	    !tb[DEVLINK_ATTR_DEV_NAME])
 		return;
 
-	sprintf(buf, "%s/%s", mnl_attr_get_str(tb[DEVLINK_ATTR_BUS_NAME]),
-		mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]));
+	snprintf(buf, sizeof(buf), "%s/%s",
+		 mnl_attr_get_str(tb[DEVLINK_ATTR_BUS_NAME]),
+		 mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]));
 	print_string(PRINT_ANY, "nested_devlink", " nested_devlink %s", buf);
 }
 
@@ -2773,7 +2774,7 @@ static void __pr_out_handle_start(struct dl *dl, struct nlattr **tb,
 	const char *dev_name = mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]);
 	char buf[64];
 
-	sprintf(buf, "%s/%s", bus_name, dev_name);
+	snprintf(buf, sizeof(buf), "%s/%s", bus_name, dev_name);
 
 	if (dl->json_output) {
 		if (array) {
@@ -2832,7 +2833,7 @@ static void pr_out_selftests_handle_start(struct dl *dl, struct nlattr **tb)
 	const char *dev_name = mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]);
 	char buf[64];
 
-	sprintf(buf, "%s/%s", bus_name, dev_name);
+	snprintf(buf, sizeof(buf), "%s/%s", bus_name, dev_name);
 
 	if (dl->json_output) {
 		if (should_arr_last_handle_end(dl, bus_name, dev_name))
@@ -2902,9 +2903,10 @@ static void __pr_out_port_handle_start(struct dl *dl, const char *bus_name,
 	if (dl->no_nice_names || !try_nice ||
 	    ifname_map_rev_lookup(dl, bus_name, dev_name,
 				  port_index, &ifname) != 0)
-		sprintf(buf, "%s/%s/%d", bus_name, dev_name, port_index);
+		snprintf(buf, sizeof(buf), "%s/%s/%d",
+			 bus_name, dev_name, port_index);
 	else
-		sprintf(buf, "%s", ifname);
+		snprintf(buf, sizeof(buf), "%s", ifname);
 
 	if (dl->json_output) {
 		if (array) {
@@ -5230,7 +5232,7 @@ pr_out_port_rate_handle_start(struct dl *dl, struct nlattr **tb, bool try_nice)
 	bus_name = mnl_attr_get_str(tb[DEVLINK_ATTR_BUS_NAME]);
 	dev_name = mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]);
 	node_name = mnl_attr_get_str(tb[DEVLINK_ATTR_RATE_NODE_NAME]);
-	sprintf(buf, "%s/%s/%s", bus_name, dev_name, node_name);
+	snprintf(buf, sizeof(buf), "%s/%s/%s", bus_name, dev_name, node_name);
 	if (dl->json_output)
 		open_json_object(buf);
 	else
@@ -6305,7 +6307,7 @@ static void pr_out_json_occ_show_item_list(struct dl *dl, const char *label,
 
 	open_json_object(label);
 	list_for_each_entry(occ_item, list, list) {
-		sprintf(buf, "%u", occ_item->index);
+		snprintf(buf, sizeof(buf), "%u", occ_item->index);
 		open_json_object(buf);
 		if (bound_pool)
 			print_uint(PRINT_JSON, "bound_pool", NULL,
@@ -8674,7 +8676,7 @@ static void pr_out_region_handle_start(struct dl *dl, struct nlattr **tb)
 	const char *region_name = mnl_attr_get_str(tb[DEVLINK_ATTR_REGION_NAME]);
 	char buf[256];
 
-	sprintf(buf, "%s/%s/%s", bus_name, dev_name, region_name);
+	snprintf(buf, sizeof(buf), "%s/%s/%s", bus_name, dev_name, region_name);
 	if (dl->json_output)
 		open_json_object(buf);
 	else
-- 
2.41.0


