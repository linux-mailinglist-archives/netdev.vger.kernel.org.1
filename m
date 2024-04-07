Return-Path: <netdev+bounces-85489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1BA89AFA1
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 10:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1BE1F21FB6
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 08:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5E110A26;
	Sun,  7 Apr 2024 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="YC69X841"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9B91097B
	for <netdev@vger.kernel.org>; Sun,  7 Apr 2024 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712478216; cv=none; b=lE2fK9SlGdCUqziH8QarIVK2A3UpkN80zSB1+4qv9TxAnOx0ucBM6jNrpBXKp78OXYD4WrmbPnK+DZOCQ1dVrCFWSO/4yFzbG8SI4RRUiFiUmxvc4/tD1qV3zBqbd055OITFycrtjYotIu7AImnaatJI7t+EDOLvuYrKDvFxMwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712478216; c=relaxed/simple;
	bh=riEiP4Gcl/XA3EZUu4seuVAUM7WGOa9UR9VUNCmxWYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmI1JzkY9FWF+10Ijn3uTLXXWK1BJJrNT5I4F0I6GcKdoDabv3MQmFVLvYacAoIqcpMhRepHnsUc0xZih3Dmmchn1gHKdRlz8wFcBIs+dG4ObupcxYMrECHQMf4NRydG34mPcgA0y7pgaz6nOVZ2tNqhOhKb9yFi99aZH/Pne0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=YC69X841; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 026ff341-f4b8-11ee-bfb8-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 026ff341-f4b8-11ee-bfb8-005056ab378f;
	Sun, 07 Apr 2024 10:22:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=AY3Td7OTAJJyuECjO9T42hDSQpbujHXqB+ReWitGCfk=;
	b=YC69X841nSlTMZhB7W/mRITb0AxIATOtKhVDGuKFRN7RVlErSVB2ak6szdLzrCbgA4bqRPLX26Kvz
	 +oDV4uUFVngHyknLOAVO5hSARMH5xrmgyoOnDwzllebmS0xvLIB3c16DFmzXaYXCII/7lqvwGmvuE1
	 9N4ayqVgKovdumHQ=
X-KPN-MID: 33|RuHod7Nz5Se+onBWFgNm/9UT00Jif+HG9Zv8XuIIlmOpVNv4hDtvVOJ9rOD4vYB
 iCxGvAA4mClszKXZjjNU3R7FN1yxJp2wpXj236uGTDmg=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|r/cguFIOnPKRqKckli8uyEuhCNzkYXe9RDdtY5YiP6KEIVmjJ2fl6h2OBfcZSMn
 4HCDnLdkZud7IhCrex8/jIA==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 186d91fc-f4b8-11ee-9f09-005056ab7584;
	Sun, 07 Apr 2024 10:23:22 +0200 (CEST)
Date: Sun, 7 Apr 2024 10:23:21 +0200
From: Antony Antony <antony@phenome.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony.antony@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	devel@linux-ipsec.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v6] xfrm: Add Direction to the
 SA in or out
Message-ID: <ZhJX-Rn50RxteJam@Antony2201.local>
References: <a53333717022906933e9113980304fa4717118e9.1712320696.git.antony.antony@secunet.com>
 <ZhBzcMrpBCNXXVBV@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8Pb5Ux0oEYrp75kr"
Content-Disposition: inline
In-Reply-To: <ZhBzcMrpBCNXXVBV@hog>


--8Pb5Ux0oEYrp75kr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sabrina,

On Fri, Apr 05, 2024 at 11:56:00PM +0200, Sabrina Dubroca via Devel wrote:
> Hi Antony,
> 
> 2024-04-05, 14:40:07 +0200, Antony Antony wrote:
> > This patch introduces the 'dir' attribute, 'in' or 'out', to the
> > xfrm_state, SA, enhancing usability by delineating the scope of values
> > based on direction. An input SA will now exclusively encompass values
> > pertinent to input, effectively segregating them from output-related
> > values. 
> 
> But this patch isn't doing that for existing properties (I'm thinking
> of replay window, not sure if any others are relevant [1]). Why not?

Thank you for raising this point.  I thought that introducing a patch for 
the replay window check could stir more controversy, which might delay the 
acceptance of the essential 'dir' feature. My primary goal at this stage is 
to get this basic feature  in and to convince Chris to integrate the "dir" 
attribute into IP-TFS. This patch has partly contributed to the delays in 
IP-TFS's development.

Given your input, I'm curious about the specific conditions you have in 
mind. See the attached patch.

For non-ESN scenarios, the outbound SA should have a replay window set to 0?  
And for ESN 1?

non-ESN
ip xfrm state add src 10.1.3.4 dst 10.1.2.3 proto esp spi 3 reqid 2  \
mode tunnel dir out aead 'rfc4106(gcm(aes))' \
0x2222222222222222222222222222222222222222 96 if_id 11 replay-window 10
Error: Replay-window too big > 0 for OUT SA.

The current impelementation does not replay window 0 with ESN.  Even though 
disabling replay window with ESN is a desired feature.

ip xfrm state add src 10.1.3.4 dst 10.1.2.3 proto esp spi 3 reqid 2 mode 
tunnel dir out flag esn  aead  'rfc4106(gcm(aes))'  \
0x2222222222222222222222222222222222222222 96 if_id 11 replay-window 10
Error: ESN replay-window too big > 1 for OUT SA.ww

I wonder would the attached patch get accepted quickly.

> 
> [1] that should include values passed via xfrm_usersa_info too,
>     not just XFRMA_* attributes
> 
> Adding these checks should be safe (wrt breakage of API): Old software
> would not be passing XFRMA_SA_DIR, so adding checks when it is provided
> would not break anything there. Only new software using the attribute
> would benefit from having directed SAs and restriction on which attributes
> can be used (and that's fine).
> 
> Right now the new attribute is 100% duplicate of the existing offload
> direction, so I don't see much point.

IP-TFS and Chris alreay expressed it. It started with this e-mail.
https://lore.kernel.org/netdev/ZV0BSBzNh3UIqueZ@Antony2201.local
I am trying to convince Chris to use "dir". Without direction I found IP-TFS 
confusing without direction.

> > This change aims to streamline the configuration process and
> > improve the overall clarity of SA attributes.
> > 
> > This feature sets the groundwork for future patches, including
> > the upcoming IP-TFS patch.
> > 
> > Currently, dir is only allowed when HW OFFLOAD is set.
> > 
> > ---
> 
> BTW, everything after this '---' will get cut, including your sign-off.

thanks for spotting it. I will send new version.

> 
> > v5->v6:
> >  - XFRMA_SA_DIR only allowed with HW OFFLOAD
> > 
> > v4->v5:
> >  - add details to commit message
> > 
> > v3->v4:
> >  - improve HW OFFLOAD DIR check check other direction
> > 
> > v2->v3:
> >  - delete redundant XFRM_SA_DIR_USE
> >  - use u8 for "dir"
> >  - fix HW OFFLOAD DIR check
> > 
> > v1->v2:
> >  - use .strict_start_type in struct nla_policy xfrma_policy
> >  - delete redundant XFRM_SA_DIR_MAX enum
> > ---
> > 
> > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> 
> nit: If I'm making non-trivial changes to the contents of the patch, I
> typically drop the review (and test) tags I got on previous versions,
> since they may no longer apply.

I agree.

-antony

--8Pb5Ux0oEYrp75kr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-xfrm-Add-Direction-to-the-SA-in-or-out.patch"

From c4b7a7232aab0adefd138170391cbe0532216642 Mon Sep 17 00:00:00 2001
From: Antony Antony <antony.antony@secunet.com>
Date: Fri, 5 Apr 2024 14:40:07 +0200
Subject: [PATCH ipsec-next v7] xfrm: Add Direction to the SA in or out

This patch introduces the 'dir' attribute, 'in' or 'out', to the
xfrm_state, SA, enhancing usability by delineating the scope of values
based on direction. An input SA will now exclusively encompass values
pertinent to input, effectively segregating them from output-related
values. This change aims to streamline the configuration process and
improve the overall clarity of SA attributes.

This feature sets the groundwork for future patches, including
the upcoming IP-TFS patch.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v6->v7:
 - add replay-window check non-esn 0 and ESN 1.
 - remove :XFRMA_SA_DIR only allowed with HW OFFLOAD

v5->v6:
 - XFRMA_SA_DIR only allowed with HW OFFLOAD

v4->v5:
 - add details to commit message

v3->v4:
 - improve HW OFFLOAD DIR check add the other direction

v2->v3:
 - delete redundant XFRM_SA_DIR_USE
 - use u8 for "dir"
 - fix HW OFFLOAD DIR check

v1->v2:
 - use .strict_start_type in struct nla_policy xfrma_policy
 - delete redundant XFRM_SA_DIR_MAX enum
---
 include/net/xfrm.h        |  1 +
 include/uapi/linux/xfrm.h |  6 ++++
 net/xfrm/xfrm_compat.c    |  7 +++--
 net/xfrm/xfrm_device.c    |  6 ++++
 net/xfrm/xfrm_state.c     |  1 +
 net/xfrm/xfrm_user.c      | 66 ++++++++++++++++++++++++++++++++++++---
 6 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 57c743b7e4fe..7c9be06f8302 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -291,6 +291,7 @@ struct xfrm_state {
 	/* Private data of this transformer, format is opaque,
 	 * interpreted by xfrm_type methods. */
 	void			*data;
+	u8			dir;
 };

 static inline struct net *xs_net(struct xfrm_state *x)
diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
index 6a77328be114..18ceaba8486e 100644
--- a/include/uapi/linux/xfrm.h
+++ b/include/uapi/linux/xfrm.h
@@ -141,6 +141,11 @@ enum {
 	XFRM_POLICY_MAX	= 3
 };

+enum xfrm_sa_dir {
+	XFRM_SA_DIR_IN	= 1,
+	XFRM_SA_DIR_OUT = 2
+};
+
 enum {
 	XFRM_SHARE_ANY,		/* No limitations */
 	XFRM_SHARE_SESSION,	/* For this session only */
@@ -315,6 +320,7 @@ enum xfrm_attr_type_t {
 	XFRMA_SET_MARK_MASK,	/* __u32 */
 	XFRMA_IF_ID,		/* __u32 */
 	XFRMA_MTIMER_THRESH,	/* __u32 in seconds for input SA */
+	XFRMA_SA_DIR,		/* __u8 */
 	__XFRMA_MAX

 #define XFRMA_OUTPUT_MARK XFRMA_SET_MARK	/* Compatibility */
diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
index 655fe4ff8621..007dee03b1bc 100644
--- a/net/xfrm/xfrm_compat.c
+++ b/net/xfrm/xfrm_compat.c
@@ -98,6 +98,7 @@ static const int compat_msg_min[XFRM_NR_MSGTYPES] = {
 };

 static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
+	[XFRMA_UNSPEC]          = { .strict_start_type = XFRMA_SA_DIR },
 	[XFRMA_SA]		= { .len = XMSGSIZE(compat_xfrm_usersa_info)},
 	[XFRMA_POLICY]		= { .len = XMSGSIZE(compat_xfrm_userpolicy_info)},
 	[XFRMA_LASTUSED]	= { .type = NLA_U64},
@@ -129,6 +130,7 @@ static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
 	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
 	[XFRMA_IF_ID]		= { .type = NLA_U32 },
 	[XFRMA_MTIMER_THRESH]	= { .type = NLA_U32 },
+	[XFRMA_SA_DIR]          = { .type = NLA_U8}
 };

 static struct nlmsghdr *xfrm_nlmsg_put_compat(struct sk_buff *skb,
@@ -277,9 +279,10 @@ static int xfrm_xlate64_attr(struct sk_buff *dst, const struct nlattr *src)
 	case XFRMA_SET_MARK_MASK:
 	case XFRMA_IF_ID:
 	case XFRMA_MTIMER_THRESH:
+	case XFRMA_SA_DIR:
 		return xfrm_nla_cpy(dst, src, nla_len(src));
 	default:
-		BUILD_BUG_ON(XFRMA_MAX != XFRMA_MTIMER_THRESH);
+		BUILD_BUG_ON(XFRMA_MAX != XFRMA_SA_DIR);
 		pr_warn_once("unsupported nla_type %d\n", src->nla_type);
 		return -EOPNOTSUPP;
 	}
@@ -434,7 +437,7 @@ static int xfrm_xlate32_attr(void *dst, const struct nlattr *nla,
 	int err;

 	if (type > XFRMA_MAX) {
-		BUILD_BUG_ON(XFRMA_MAX != XFRMA_MTIMER_THRESH);
+		BUILD_BUG_ON(XFRMA_MAX != XFRMA_SA_DIR);
 		NL_SET_ERR_MSG(extack, "Bad attribute");
 		return -EOPNOTSUPP;
 	}
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 6346690d5c69..2455a76a1cff 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -253,6 +253,12 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		return -EINVAL;
 	}

+	if ((xuo->flags & XFRM_OFFLOAD_INBOUND && x->dir == XFRM_SA_DIR_OUT) ||
+	    (!(xuo->flags & XFRM_OFFLOAD_INBOUND) && x->dir == XFRM_SA_DIR_IN)) {
+		NL_SET_ERR_MSG(extack, "Mismatched SA and offload direction");
+		return -EINVAL;
+	}
+
 	is_packet_offload = xuo->flags & XFRM_OFFLOAD_PACKET;

 	/* We don't yet support UDP encapsulation and TFC padding. */
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 0c306473a79d..749c9cf41c06 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1744,6 +1744,7 @@ static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
 	x->lastused = orig->lastused;
 	x->new_mapping = 0;
 	x->new_mapping_sport = 0;
+	x->dir = orig->dir;

 	return x;

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 810b520493f3..c86853ef9e59 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -360,6 +360,36 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 		}
 	}

+	if (attrs[XFRMA_SA_DIR]) {
+		u8 sa_dir = nla_get_u8(attrs[XFRMA_SA_DIR]);
+
+		if (sa_dir != XFRM_SA_DIR_IN && sa_dir != XFRM_SA_DIR_OUT)  {
+			NL_SET_ERR_MSG(extack, "XFRMA_SA_DIR attribute is out of range");
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (sa_dir == XFRM_SA_DIR_OUT)  {
+			if (p->replay_window > 0) {
+				NL_SET_ERR_MSG(extack, "Replay-window too big > 0 for OUT SA");
+				err = -EINVAL;
+				goto out;
+			}
+
+			if (attrs[XFRMA_REPLAY_ESN_VAL]) {
+				struct xfrm_replay_state_esn *esn;
+
+				esn = nla_data(attrs[XFRMA_REPLAY_ESN_VAL]);
+				if (esn->replay_window > 1) {
+					NL_SET_ERR_MSG(extack,
+						       "ESN replay-window too big > 1 for OUT SA");
+					err = -EINVAL;
+					goto out;
+				}
+			}
+		}
+	}
+
 out:
 	return err;
 }
@@ -627,6 +657,7 @@ static void xfrm_update_ae_params(struct xfrm_state *x, struct nlattr **attrs,
 	struct nlattr *et = attrs[XFRMA_ETIMER_THRESH];
 	struct nlattr *rt = attrs[XFRMA_REPLAY_THRESH];
 	struct nlattr *mt = attrs[XFRMA_MTIMER_THRESH];
+	struct nlattr *dir = attrs[XFRMA_SA_DIR];

 	if (re && x->replay_esn && x->preplay_esn) {
 		struct xfrm_replay_state_esn *replay_esn;
@@ -661,6 +692,9 @@ static void xfrm_update_ae_params(struct xfrm_state *x, struct nlattr **attrs,

 	if (mt)
 		x->mapping_maxage = nla_get_u32(mt);
+
+	if (dir)
+		x->dir = nla_get_u8(dir);
 }

 static void xfrm_smark_init(struct nlattr **attrs, struct xfrm_mark *m)
@@ -1182,8 +1216,13 @@ static int copy_to_user_state_extra(struct xfrm_state *x,
 		if (ret)
 			goto out;
 	}
-	if (x->mapping_maxage)
+	if (x->mapping_maxage) {
 		ret = nla_put_u32(skb, XFRMA_MTIMER_THRESH, x->mapping_maxage);
+		if (ret)
+			goto out;
+	}
+	if (x->dir)
+		ret = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
 out:
 	return ret;
 }
@@ -2402,7 +2441,8 @@ static inline unsigned int xfrm_aevent_msgsize(struct xfrm_state *x)
 	       + nla_total_size_64bit(sizeof(struct xfrm_lifetime_cur))
 	       + nla_total_size(sizeof(struct xfrm_mark))
 	       + nla_total_size(4) /* XFRM_AE_RTHR */
-	       + nla_total_size(4); /* XFRM_AE_ETHR */
+	       + nla_total_size(4) /* XFRM_AE_ETHR */
+	       + nla_total_size(sizeof(x->dir)); /* XFRMA_SA_DIR */
 }

 static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)
@@ -2459,6 +2499,12 @@ static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct
 	if (err)
 		goto out_cancel;

+	if (x->dir) {
+		err = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
+		if (err)
+			goto out_cancel;
+	}
+
 	nlmsg_end(skb, nlh);
 	return 0;

@@ -3018,6 +3064,7 @@ EXPORT_SYMBOL_GPL(xfrm_msg_min);
 #undef XMSGSIZE

 const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
+	[XFRMA_UNSPEC]		= { .strict_start_type = XFRMA_SA_DIR },
 	[XFRMA_SA]		= { .len = sizeof(struct xfrm_usersa_info)},
 	[XFRMA_POLICY]		= { .len = sizeof(struct xfrm_userpolicy_info)},
 	[XFRMA_LASTUSED]	= { .type = NLA_U64},
@@ -3049,6 +3096,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
 	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
 	[XFRMA_IF_ID]		= { .type = NLA_U32 },
 	[XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
+	[XFRMA_SA_DIR]          = { .type = NLA_U8 }
 };
 EXPORT_SYMBOL_GPL(xfrma_policy);

@@ -3189,8 +3237,9 @@ static void xfrm_netlink_rcv(struct sk_buff *skb)

 static inline unsigned int xfrm_expire_msgsize(void)
 {
-	return NLMSG_ALIGN(sizeof(struct xfrm_user_expire))
-	       + nla_total_size(sizeof(struct xfrm_mark));
+	return NLMSG_ALIGN(sizeof(struct xfrm_user_expire)) +
+	       nla_total_size(sizeof(struct xfrm_mark)) +
+	       nla_total_size(sizeof_field(struct xfrm_state, dir));
 }

 static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)
@@ -3217,6 +3266,12 @@ static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct
 	if (err)
 		return err;

+	if (x->dir) {
+		err = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
+		if (err)
+			return err;
+	}
+
 	nlmsg_end(skb, nlh);
 	return 0;
 }
@@ -3324,6 +3379,9 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
 	if (x->mapping_maxage)
 		l += nla_total_size(sizeof(x->mapping_maxage));

+	if (x->dir)
+		l += nla_total_size(sizeof(x->dir));
+
 	return l;
 }

--
2.43.0


--8Pb5Ux0oEYrp75kr--

