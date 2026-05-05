Return-Path: <netdev+bounces-284148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM7KIIVG+Wki7gIAu9opvQ
	(envelope-from <netdev+bounces-284148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 03:23:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBC14C5BAC
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 03:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97DBE3010B8E
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 01:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FE5332621;
	Tue,  5 May 2026 01:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KL4gnMYl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2565C613
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 01:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777944195; cv=pass; b=pKPTCb27J8JcGzjjfNY+KZKe0w6TvzBW8WWKYRrPK7rcz38NOSK+Nozrn3c8VsyKzDtl2MMsTIyh5EZ/LsY46z9gdmKPgxzFm9c3x8VLlmcc/1Uff3PwlOyy8fc94GxbFM0G56Qm3tXixM3RFDzHHLfU/zq5diosOGmRjBkroKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777944195; c=relaxed/simple;
	bh=Rr3wU4+uo7PsSxYrNtmT6CjW/2oWhP4X5/7X8ZQP0tA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1Qu7Y8b6jorxxuO0cawEws3HWk4kZBIQen7WUjskq3ewR26uysyQHCuKZdoBDCyhBDVt6mtEDODdk2sjDEGZEKL0VK2E8iHk0cwY9o44Yght8mzmxCYq6wm0pAjRRsvHRlDTlQL+7YWqc8NwvFRFRh+uG8XTORzoUMR+jAzVus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KL4gnMYl; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67b8d9c26bbso6145045a12.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 18:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777944192; cv=none;
        d=google.com; s=arc-20240605;
        b=ZFkikmQC80QjgMd96VNiIBwTGCozFw5JlfbVR2OonwMTjeu1OCkHXzQ62i06WYWpJM
         45v1wW0zEkUAq7XWAALpDXf584nS0VpLHqcozGPLEnNDM3Y2xvLiP8R8Q+UKVclJcWp/
         klsJOY9tOo6RZAkLm877w50bY1UtiaMNBir5zBkP08Kv/oZ0kZRCbJORczjtIf6kGK0k
         bOOa5EpisUZkHZmCrd5DR9WV3YDbgjKEcT480RZxFFE8fX5m7elp1B11Q6o7YXaWejnp
         OIwe4HG11vJzNFjuDq6rn6fLj0BlGAR7OeQ8qIqZy3HVn58wqrgxcgNKpeHMPiTMm182
         BkRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cCXrAWmoAymL9ifKCG4c/wEuHOu5FPfo6N65MqG9vPs=;
        fh=iuRHt7dolYZH6iFBvp8zeByKnv36cRFQjsgFAkZBaeE=;
        b=CPch1yAiQkeXvL5nyuzFRfGsHTERBDmDd3ytoqzieQbNwcJsnVq/8kFwaOXRRZt79E
         Dn4h4o/YCrpay+OiH5dqOEIQXKIdi7PthFZ6u1sl0hrsruqoR7TMdq3ky2a2ddb5qkVC
         zoi0dxZUBi38YjxH0BPgoCaZxf037aJDhzS3R+809i4MwqUvzbxaJgpUGTcBque35giX
         hdsnO21z7LLe9n0dXQsOCRtmXEDQWWDSUfR4ThFj5Bzdm6ogCfHbADiC2YkWUNcbJ1wG
         sXh++5h4yVns9ckYg2hLzCMeEz25pAOvHIicDJcxdr33wKzk2e4UctYuiK1xLFiT9rpl
         SlDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777944192; x=1778548992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCXrAWmoAymL9ifKCG4c/wEuHOu5FPfo6N65MqG9vPs=;
        b=KL4gnMYlcA1PF8bTf7kOe2sd5FK3/paFvLZPyIrGLO/mpUp05Wk357vRzuAVydpSzX
         fHLbvt2C2I7+x8Nc83g56+DwMz2fIJ4bxIC0suemFM5i9FulLwqe7Nb/3xHpaMeHl03b
         9IDX+bvC2KLMQDPuSD7PwNN7SqpfDQ+iKXase/bJmSEFlYE7g8eKnc5qSVvJCTAHEbKQ
         m7iixZKURyplgTeE24eOIsNftklf9pyN2rR/PDdm4fHlwp0l1KSIStQf3pIxV2cY++Qs
         Wa+/E6sB+cdfVjMLI7n51C2VVKvrjMQILqbdBfIr1mq7BkhQpdDi3LVet4vUo2v4eVe1
         NElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777944192; x=1778548992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cCXrAWmoAymL9ifKCG4c/wEuHOu5FPfo6N65MqG9vPs=;
        b=Nvsj5n1kgmfynJlJUBQUopEyprdKUX0I7zcPqsZh5d0z1N3QTW6RcuMOR1537y6DHG
         9mtrO6pWjI1UVX/qsbk2+HONmttO+SXxoL6Pg+dnmmjTuh0cxrnRPONQ1i3aOF0a06ZU
         SGbnT8pAW/aLCmmw+iYHOAlCt2JTpsfXT5Xq992qDn8Y6or/Oa8D55CyfUsHa5v5ywJl
         CCY7unS4vCmlI8alvbTMGp52FXZEQ2nXR4QQ1yPdICanE2zeFg9wJn8h3n3Xn86PDyKh
         50SYoueKaj5rcUCHpkx4o22SdjXp0siqff1D+UStuqDyR1sl5Lv1oFTXUGjb37OtCSEf
         vjyQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dLDpXlb1QjH5x6/oWgjxz82qbOcGoH72A5SFVlOjWF16pxA57BaWkFczWK+oTc/thwPW1W5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb5xt/Pdlfr25D0xfK+QkzNNm/A6q8L6P6MWMR1mSzejuQxe1S
	0IoegaL5uP4GNGAFvLoWgKCU7Uy+EpwLZVu/oJrY5oBuLUb3+9QFoZ4p2dNk7dCDzTaAN8P38lR
	MlaeOMch0YY5DaDjAmdnTjdid42BONcQ=
X-Gm-Gg: AeBDiet2yyYCtyViyIe2dcaD2WJb/DFPega5S2eXPp/L0Qin+sxXxeGrZJT64NZ4lMn
	8ovodr5pMgAY0hegonXU+0lH/SeXjoxNI93olaN95gCK/kUF1uAKYTmq6qcU62W7vEOsdXrEO1R
	cxycmsgzIGqatUYK3wJ+mFbxfBstXqwvagpvC2bHhTUq5yifequaZinx3LX5nsgEH8mqRa7aY9z
	ZQE3xc26I808lr5OwedZ1g8GLnMYuBvAQnl/GVz0iU8GgGw2EBHrC0Q70rTPJfzkchIP9TaSB4s
	wfezaf6iCWf/IEXg1tU=
X-Received: by 2002:aa7:c904:0:b0:66e:43ef:2951 with SMTP id
 4fb4d7f45d1cf-67c19929fdamr4132069a12.4.1777944191864; Mon, 04 May 2026
 18:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com> <20260504163915.4a8b028e@kernel.org>
In-Reply-To: <20260504163915.4a8b028e@kernel.org>
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Tue, 5 May 2026 10:22:58 +0900
X-Gm-Features: AVHnY4Ks42sm_qgbhHJDSLEyR_36W-fEa54mnTPR5nGVrmyYGFlRodbG56Qn8nQ
Message-ID: <CAGCJULP83NnaX6HAqwb3umDXsxN8LH48_gPpJ_3gG8_xA96QNQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] seg6: add SRv6 Mobile User Plane (RFC 9433) behaviors
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrea Mayer <andrea.mayer@uniroma2.it>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DBBC14C5BAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284148-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]

2026=E5=B9=B45=E6=9C=885=E6=97=A5=E7=81=AB=E6=9B=9C=E6=97=A5 Jakub Kicinski=
 <kuba@kernel.org>:
> Could you switch to posting this as an RFC until you gather some review
> tags? Our CI require manual intervention to add the necessary iproute2
> patches, I suspect there may be some uAPI changes therefore requiring
> iproute2 changes here.

Will do.  Yes, this series adds new SEG6_LOCAL_* / SEG6_LOCAL_MOBILE_*
uAPI in include/uapi/linux/seg6_local.h; the matching iproute2-next
series is posted separately:

  https://lore.kernel.org/netdev/20260505-seg6-mobile-v2-0-93291b7b0134@gma=
il.com/

Just to confirm the workflow you'd prefer: should I repost the
current series immediately as [PATCH RFC net-next v3 ...], or wait
for technical review on v2 to land and fold it into a v3 RFC?

Thanks,
Yuya

