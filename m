Return-Path: <netdev+bounces-40000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713217C55D1
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 15:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E9A1C209CF
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 13:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6B3200A4;
	Wed, 11 Oct 2023 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jpxjRvG2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3CC1F920
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 13:46:53 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003CEC6
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:46:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53b962f09e0so6906264a12.0
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697032009; x=1697636809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=anVbIGFD/xQXnVctqs6NiW8ia3JsnxB8kb9F2mCYrvw=;
        b=jpxjRvG2GJNNcmWJEhsdZf7o2uGKxUdVCjlQnWTG9dQASpmFBlEsGn2iYI22dj8pZ1
         tGign+y6j0tn7PNOkwIkKMnqppnBaUHCnQRkFM8jNkvuSdLcb1Nb2gdZOEq3Mg/UHRHD
         PWtJgppUITsPMZzV/l3KzE9wrwx5zaI5dYbgh8Qg/BQPeThKqta9TWpZul0jUmi11q0C
         l+eVFccSNOZNpYB3zhGa4V8WRUhvE3GI2XqWjWX6+kKJpEaYe5A3eFs8IVw4OQ1T+7zP
         SFitUcl3ANhwEQf3xQ5uWCUV/H9Rz04VAH6aHMcN+l3TizVb15IAOcwtQLIL62QHqzWW
         hMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697032009; x=1697636809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anVbIGFD/xQXnVctqs6NiW8ia3JsnxB8kb9F2mCYrvw=;
        b=N/ie4p7yFrbRLfHWHc7v53F9yInIWP/Fb4D7kSjBxn81sSBgZ/pAY19TgCZIP6/RWV
         xFGtfD6ixbnIB9B8cBkdJgIj/rlHCtqjHe3anB4FTbYmVLQIdOAUKoPQWPJP3v7BjVnv
         +NdxJYS9wpIukbyOLHA9gOGxN8mHbVgq+hNXLnq0frp2xarWEpOR81CmZYeOI2didiA9
         Oob8VajWNkUatJaF1FMoFaMmP82LiPKTaa48HKBdwh9OTphmIWQDM1AKZuusHxEygRGv
         HSNk8mlPG/4TLqAR7p/oTnCeeclho6HtKeOBnmOeR1iXgv8DzxM25302poBC40MKg2Mi
         PHVQ==
X-Gm-Message-State: AOJu0YwgkaOflBss6azyZIZoXRowXg9TAaNSUwENCWtQb4Pg86c2G5aO
	SHg+h8nv9DrJsb2xUSPIXRCloA==
X-Google-Smtp-Source: AGHT+IG4jBToGEzxhhb3hbvvtiaESf4CzvX+W82I3M8QxntBFCd78SFqwb0LS4306g/ZyuYAI/NbJQ==
X-Received: by 2002:a17:906:2101:b0:9b8:8bcf:8732 with SMTP id 1-20020a170906210100b009b88bcf8732mr18626366ejt.43.1697032009320;
        Wed, 11 Oct 2023 06:46:49 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id y23-20020a1709064b1700b009aa292a2df2sm9720163eju.217.2023.10.11.06.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 06:46:48 -0700 (PDT)
Date: Wed, 11 Oct 2023 15:46:47 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, nicolas.dichtel@6wind.com,
	johannes@sipsolutions.net, fw@strlen.de, pablo@netfilter.org,
	mkubecek@suse.cz, aleksander.lobakin@intel.com
Subject: Re: [RFC] netlink: add variable-length / auto integers
Message-ID: <ZSanRz7kV1rduMBE@nanopsycho>
References: <20231011003313.105315-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011003313.105315-1-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Oct 11, 2023 at 02:33:13AM CEST, kuba@kernel.org wrote:
>We currently push everyone to use padding to align 64b values in netlink.
>I'm not sure what the story behind this is. I found this:
>https://lore.kernel.org/all/1461339084-3849-1-git-send-email-nicolas.dichtel@6wind.com/#t
>but it doesn't go into details WRT the motivation.
>Even for arches which don't have good unaligned access - I'd think
>that access aligned to 4B *is* pretty efficient, and that's all
>we need. Plus kernel deals with unaligned input. Why can't user space?
>
>Padded 64b is quite space-inefficient (64b + pad means at worst 16B
>per attr vs 32b which takes 8B). It is also more typing:
>
>    if (nla_put_u64_pad(rsp, NETDEV_A_SOMETHING_SOMETHING,
>                        value, NETDEV_A_SOMETHING_PAD))
>
>Create a new attribute type which will use 32 bits at netlink
>level if value is small enough (probably most of the time?),
>and (4B-aligned) 64 bits otherwise. Kernel API is just:
>
>    if (nla_put_uint(rsp, NETDEV_A_SOMETHING_SOMETHING, value))
>
>Calling this new type "just" sint / uint with no specific size
>will hopefully also make people more comfortable with using it.
>Currently telling people "don't use u8, you may need the space,
>and netlink will round up to 4B, anyway" is the #1 comment
>we give to newcomers.
>
>In terms of netlink layout it looks like this:
>
>         0       4       8       12      16
>32b:     [nlattr][ u32  ]
>64b:     [  pad ][nlattr][     u64      ]
>uint(32) [nlattr][ u32  ]
>uint(64) [nlattr][     u64      ]
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
>Thoughts?

Hmm, I assume that genetlink.yaml schema should only allow uint and sint
to be defined after this, so new genetlink implementations use just uint
and sint, correct?

Than we have genetlink.yaml genetlink-legacy.yaml genetlink-legacy2.yaml
?
I guess in the future there might be other changes to require new
implemetation not to use legacy things. How does this scale?

+ 2 nits below



>
>This is completely untested. YNL to follow.
>---
> include/net/netlink.h        | 62 ++++++++++++++++++++++++++++++++++--
> include/uapi/linux/netlink.h |  5 +++
> lib/nlattr.c                 |  9 ++++++
> net/netlink/policy.c         | 14 ++++++--
> 4 files changed, 85 insertions(+), 5 deletions(-)
>
>diff --git a/include/net/netlink.h b/include/net/netlink.h
>index 8a7cd1170e1f..523486dfe4f3 100644
>--- a/include/net/netlink.h
>+++ b/include/net/netlink.h
>@@ -183,6 +183,8 @@ enum {
> 	NLA_REJECT,
> 	NLA_BE16,
> 	NLA_BE32,
>+	NLA_SINT,

Why not just NLA_INT?


>+	NLA_UINT,
> 	__NLA_TYPE_MAX,
> };
> 
>@@ -377,9 +379,11 @@ struct nla_policy {
> 
> #define __NLA_IS_UINT_TYPE(tp)					\
> 	(tp == NLA_U8 || tp == NLA_U16 || tp == NLA_U32 ||	\
>-	 tp == NLA_U64 || tp == NLA_BE16 || tp == NLA_BE32)
>+	 tp == NLA_U64 || tp == NLA_UINT ||			\
>+	 tp == NLA_BE16 || tp == NLA_BE32)
> #define __NLA_IS_SINT_TYPE(tp)						\
>-	(tp == NLA_S8 || tp == NLA_S16 || tp == NLA_S32 || tp == NLA_S64)
>+	(tp == NLA_S8 || tp == NLA_S16 || tp == NLA_S32 || tp == NLA_S64 || \
>+	 tp == NLA_SINT)
> 
> #define __NLA_ENSURE(condition) BUILD_BUG_ON_ZERO(!(condition))
> #define NLA_ENSURE_UINT_TYPE(tp)			\
>@@ -1357,6 +1361,22 @@ static inline int nla_put_u32(struct sk_buff *skb, int attrtype, u32 value)
> 	return nla_put(skb, attrtype, sizeof(u32), &tmp);
> }
> 
>+/**
>+ * nla_put_uint - Add a variable-size unsigned int to a socket buffer
>+ * @skb: socket buffer to add attribute to
>+ * @attrtype: attribute type
>+ * @value: numeric value
>+ */
>+static inline int nla_put_uint(struct sk_buff *skb, int attrtype, u64 value)
>+{
>+	u64 tmp64 = value;
>+	u32 tmp32 = value;
>+
>+	if (tmp64 == tmp32)
>+		return nla_put_u32(skb, attrtype, tmp32);

It's a bit confusing, perheps better just to use nla_put() here as well?

>+	return nla_put(skb, attrtype, sizeof(u64), &tmp64);
>+}
>+
> /**
>  * nla_put_be32 - Add a __be32 netlink attribute to a socket buffer
>  * @skb: socket buffer to add attribute to

[...]

