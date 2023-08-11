Return-Path: <netdev+bounces-26636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09DA77879C
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 08:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10D41C210A6
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 06:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45781104;
	Fri, 11 Aug 2023 06:44:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A27FA35
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 06:44:32 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D72D2D54
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:44:31 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c0cb7285fso222710066b.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691736270; x=1692341070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N03UHCmrG/LVy//yym8vnoEJFbB8uNeazen0KMtCGXo=;
        b=1tSc+YlHmna0FHD+4CsdlwbHLj0+ouUNA22QwJveQq71RW5EzPumgsTCtjltJkU48T
         BF3sh0tFcgjBTH3cC9aChjNS4/DSDBgyYiY87t72dFPxnKmx8I8yYILqbkRb5cF+FBu0
         OBBFvi10gtTKDhxy/mH1CRvke/dDL8YIFkVvGWNKreuiZsmwfMboPFhE8/MKrU41vOVK
         3ElyqiWCbBTRho54QOCjWEf05oezEDFrObpdbbMpmPPnpL7RgYyuVy0csvvxzw2HCU6v
         OcTrrz+hiFMCK/tK5ksNZghpnl8sRvRgXE15iyzUP4zeDAWHaOHEearp+qqJKnhrKDKF
         peMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691736270; x=1692341070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N03UHCmrG/LVy//yym8vnoEJFbB8uNeazen0KMtCGXo=;
        b=SykQQQL3g/Rc6rJ1ETnMu3pWQiirtpCVFKJh18P/VBSwfjYaKa8s9MyQa1kh2XfOz2
         O6xKfqVYjO8SY9wHW3bd6r0K8qLOA12EgJkqPwLnuXRZfXdRZfZq8BEz1kukilJgXCQH
         kNKJW9E5AsnGBFlV5MLJinzrIFq+H9K/+b1QfAd/2ZJD4kdIOYSyH6fTz1m0DJ3OITaJ
         5dAaP9GOzYOeF9MPpj2cqdUfNVs6HRH8oGO9OXo5MOyxrWUBjE8G5h8eUEvE/w7hhRUj
         nL57GXLAYPsoZeMzf6rQzEvlLktd3nJXXL7NY/MnIGp9mTcnbRErh6xZUDmunNjv9bd0
         hi0w==
X-Gm-Message-State: AOJu0YzlSdEW64L5zJXZyvOHyoTmAOnRm0k0TA1ZsV9lUeadL//GGxqx
	2UN/kj1JjuEx42CeVflDskc6CA==
X-Google-Smtp-Source: AGHT+IFBgIZGrUrNzstwmFRoxuIwfxTi0gsR3bMc0vfRldgIiVQ23WL43m+kZw77moSS9k76Q4+ArA==
X-Received: by 2002:a17:906:cc2:b0:99c:5056:4e2e with SMTP id l2-20020a1709060cc200b0099c50564e2emr754897ejh.31.1691736269721;
        Thu, 10 Aug 2023 23:44:29 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id m13-20020a170906234d00b0099bd7b26639sm1865994eja.6.2023.08.10.23.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 23:44:29 -0700 (PDT)
Date: Fri, 11 Aug 2023 08:44:28 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes@sipsolutions.net
Subject: Re: [PATCH net-next v2 07/10] genetlink: add genlmsg_iput() API
Message-ID: <ZNXYzJKTENOO/OgG@nanopsycho>
References: <20230810233845.2318049-1-kuba@kernel.org>
 <20230810233845.2318049-8-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810233845.2318049-8-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 11, 2023 at 01:38:42AM CEST, kuba@kernel.org wrote:
>Add some APIs and helpers required for convenient construction
>of replies and notifications based on struct genl_info.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
> include/net/genetlink.h | 54 ++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 53 insertions(+), 1 deletion(-)
>
>diff --git a/include/net/genetlink.h b/include/net/genetlink.h
>index 6b858c4cba5b..e18a4c0d69ee 100644
>--- a/include/net/genetlink.h
>+++ b/include/net/genetlink.h
>@@ -113,7 +113,7 @@ struct genl_info {
> 	struct netlink_ext_ack *extack;
> };
> 
>-static inline struct net *genl_info_net(struct genl_info *info)
>+static inline struct net *genl_info_net(const struct genl_info *info)
> {
> 	return read_pnet(&info->_net);
> }
>@@ -270,6 +270,32 @@ genl_info_dump(struct netlink_callback *cb)
> 	return &genl_dumpit_info(cb)->info;
> }
> 
>+/**
>+ * genl_info_init_ntf() - initialize genl_info for notifications
>+ * @info:   genl_info struct to set up
>+ * @family: pointer to the genetlink family
>+ * @cmd:    command to be used in the notification
>+ *
>+ * Initialize a locally declared struct genl_info to pass to various APIs.
>+ * Intended to be used when creating notifications.
>+ */
>+static inline void
>+genl_info_init_ntf(struct genl_info *info, const struct genl_family *family,
>+		   u8 cmd)
>+{
>+	struct genlmsghdr *hdr = (void *) &info->user_ptr[0];
>+
>+	memset(info, 0, sizeof(*info));
>+	info->family = family;
>+	info->genlhdr = hdr;
>+	hdr->cmd = cmd;
>+}

This looks good. Please see my comment to genl_info_is_ntf() in the
reply to the last patch. Anyway, if you decide to keep it, I'm fine:

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


>+
>+static inline bool genl_info_is_ntf(const struct genl_info *info)
>+{
>+	return !info->nlhdr;
>+}
>+
> int genl_register_family(struct genl_family *family);
> int genl_unregister_family(const struct genl_family *family);
> void genl_notify(const struct genl_family *family, struct sk_buff *skb,
>@@ -278,6 +304,32 @@ void genl_notify(const struct genl_family *family, struct sk_buff *skb,
> void *genlmsg_put(struct sk_buff *skb, u32 portid, u32 seq,
> 		  const struct genl_family *family, int flags, u8 cmd);
> 
>+static inline void *
>+__genlmsg_iput(struct sk_buff *skb, const struct genl_info *info, int flags)
>+{
>+	return genlmsg_put(skb, info->snd_portid, info->snd_seq, info->family,
>+			   flags, info->genlhdr->cmd);
>+}
>+
>+/**
>+ * genlmsg_iput - start genetlink message based on genl_info
>+ * @skb: skb in which message header will be placed
>+ * @info: genl_info as provided to do/dump handlers
>+ *
>+ * Convenience wrapper which starts a genetlink message based on
>+ * information in user request. @info should be either the struct passed
>+ * by genetlink core to do/dump handlers (when constructing replies to
>+ * such requests) or a struct initialized by genl_info_init_ntf()
>+ * when constructing notifications.
>+ *
>+ * Returns pointer to new genetlink header.
>+ */
>+static inline void *
>+genlmsg_iput(struct sk_buff *skb, const struct genl_info *info)
>+{
>+	return __genlmsg_iput(skb, info, 0);
>+}
>+
> /**
>  * genlmsg_nlhdr - Obtain netlink header from user specified header
>  * @user_hdr: user header as returned from genlmsg_put()
>-- 
>2.41.0
>

