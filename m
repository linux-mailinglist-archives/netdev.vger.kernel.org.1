Return-Path: <netdev+bounces-267847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kgdgNgbBtWkA4wAAu9opvQ
	(envelope-from <netdev+bounces-267847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 21:11:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB6E28EB8C
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 21:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DF293013245
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 20:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD01E383C96;
	Sat, 14 Mar 2026 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SrHU/i24"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB67383C80
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519107; cv=pass; b=WqLYDn/Cy0+JBEyNbqLFUWxnjlkiOAYiqfHfDR1y3Htin7cpIsWAttVSedO62I4Tqqajw/00VeJW4nQlWmZobghTXe18/VpqIqWTCXQFWhSis58YM3s9SjU008SzkuDuIH/lfjKescqHaekKeYJi7SYdcw8oOPU1I5z5s9pqlbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519107; c=relaxed/simple;
	bh=WkoXS075KSuaK6414fUI51pkZ2edKA0Qw+i5/cmums8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emhpN2nTpox3RNEnC3wadk4hi+NG4kSQS96StRSicpL5/50dzxdiOFpebToIYBCtKp5HoyujgzlX8ZkLTYsTiu2Ey3UQBYi8zQSusWTqhZO4oVBsrgNWL37AqIORkWmwFSoNOzjFrQBCamc45BQ1XbLjFrh2AuTk4UPW1hqZpjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SrHU/i24; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50919fc3a14so38887601cf.2
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 13:11:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773519105; cv=none;
        d=google.com; s=arc-20240605;
        b=SBXM/1rq4WvhCpJjwcEDZzfA1S6D/EhS15+qd1ZcRoGYuG21GbB4j76n5nPE7C9Z+d
         lHRDKkWoz8Oxycs01h3lJQyXF/w1GuueZ2l9yu5U8GBW7OQjhBaMFgIH1acpRj4idNKD
         dst7YUfFjlD50RsZX0wjHuj5mj82c0k8Vl8bgEYzHhnlR9mrTyg3n00RqkeK3tHN5/wK
         O7njdtzJFVa/3hhHOxTt9Bbq4l5BBjs7eQotukKqvGEOYpxRHcHqflP50JdzKF4C6+0L
         DaC99i5DMwxvFb197MtzHxI+T1gmOKtUE6yomqOWx3M/Ttq0YSZZuoSm3VR1VFBZQWcd
         entA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wNJU/EqgLDF0Q3nkWlyJwfLqn0QHXXY9993On9npY90=;
        fh=X+d0e9JawFIICdpRHWxFFt1D3S4yd1NQEDdcFwL3D1A=;
        b=g+Si7xlnZJkzZ58U+x7Qgc13wrPTig/Te2De6KzQGVLWsXqi9zGMFqB0M+n2aeToo8
         mFh6KJX0JcXh5TYqqglnElYFkchi938s4ChOazGNi3GNntS6qF/4R1tEJZYyfgTuOYJJ
         DlxUjsLWR7EbY66zQnyK9AU9xQ+gY3EKkXTKPTfpfMKpohyRq87njj5YJGSD5FSBSbDu
         K656uA/z3QlcVRnBuz4DSp8xz0q2Wtqbf9GJem8iN0FnlYsytQJR/ZxeykByjEXBqa14
         6XLVg71UiobSc4rRzKm3uzljQq7/PJZR+SDcWD3EHUTmTIgG7bdxEc9bG7Jk5HtlJHDR
         A4yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773519105; x=1774123905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNJU/EqgLDF0Q3nkWlyJwfLqn0QHXXY9993On9npY90=;
        b=SrHU/i24kV9sDpGMez2qT5mcAnJZfH+F35kTOj9W5AYf5xbPOMzYoMmxAplnd4OQ66
         +oeIeqaDn60RD1XwvjMSLPiAXwlppghAh9gjM/to8csuF7LMs1acC1KjMKo/xzfywOus
         sHr1zXqs1DHQ47XI/uE185qNrRqrnNDAgEzvQ+6jiQrbaaMeGKFBwLZEBrZ7khqpvRLj
         z9wJglrT5N43+zyqJ3FrF3Jp6FiKDtaTynm/WtQLPzmfsI9Yl8qMCD6mDviSiYwN6SxU
         0ndwAdykRAJkbxDr7Mr+NMXzAX1kMrUrTxtuJG+C1LVHcN6A7Ms+fVahpMVP1E35nU31
         XHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519105; x=1774123905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wNJU/EqgLDF0Q3nkWlyJwfLqn0QHXXY9993On9npY90=;
        b=UmDKCvO73Qe2z5vbSaPibzDedzPcg9x66rViD9buogzxflGHNldAbVCCk3ZKgNz1mn
         uzcjGgh7MrjvfV3hns+WIB9VvWTD6xwpVvZsesunfVHndtYb6L6ypDBlxa3yaRnvZn1X
         iRMy2sDbF1Ptvl/0F/9lMFeGdXth2RNGVvatvozIfEMIcsKca6DZ7UFZuqi9+aGcjRfs
         ou8/SRAxDt0hnWNrnmZLE3yRhNopT+ggBh/7bv03TarMzRIuX3JH6MQ2VD28yXhg3b8C
         L8G2I61u9H0grttC8He33KXY+r+QjJPFMMsj+rcZxcit+7GjzzaviFweQuekJMp+AW2d
         +0Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWyWoBXiDf6imvx7WDU/D96iKTOgH6rnCetpe4lqa84Fs7BfNkAVPubDJAYPwiRPoJYwjUj6nY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzwuxBG22ROI3zD0Jdgk25jubLv8imZcNpdVMwXtoQNfCwwHOg
	xJRJIRwkG9wRe6vtmzMXT0sTDNYSdDQaMCpD5PPXlyELV1D+aOYXKCDWigjzHXUw28PiTAknI7g
	GYT43L8Y2rB7XnM+m8pfgx1nqjdDvO6dP5ZjZAp2P
X-Gm-Gg: ATEYQzzvoh52LyDjUml2ur9K4Q82TtC07/Dt7JPXgCZqhLQqPQspdnFZzTEAvitiONp
	GK8RhjZJbqCj0u1IMZFZQ+zwWFtlt1/uKsE7PdcGiHJKbwtfzvHpJAqtLdtIq6pNEBVZf4aNvLT
	0K2F9HoTpv22/kwun9LlompFuHcxd2PCEjd4143iQfltZbXmWPWovyK6jDoGmKFGpGxzOQiBZIW
	NoZtTG7I9eOFc6yOR9me0WtnJsK9bjTk/TmTmDdUU4LfpC1cq+pvZ95tpA1o59TRDftxhgFKIZp
	pi4N72UH
X-Received: by 2002:a05:622a:1913:b0:509:1cf9:ea0e with SMTP id
 d75a77b69052e-50957e6d9ebmr106751231cf.41.1773519104360; Sat, 14 Mar 2026
 13:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312025406.15641-1-xietangxin@yeah.net> <20260314124017.59206dac@kernel.org>
In-Reply-To: <20260314124017.59206dac@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Mar 2026 21:11:33 +0100
X-Gm-Features: AaiRm51U9n8JmYbi4nsFyK5po3qG7vw7KdHuv209pKgETRH95O2uglDU7CC6gfk
Message-ID: <CANn89iJHp+nCcAo7tzMTfH5yW2qDsEXP_u=RzdV=DC9ZvDH9Fg@mail.gmail.com>
Subject: Re: [PATCH net v2] virtio_net: Fix UAF on dst_ops when
 IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
To: Jakub Kicinski <kuba@kernel.org>
Cc: xietangxin <xietangxin@yeah.net>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267847-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[yeah.net,redhat.com,davemloft.net,lunn.ch,linux.alibaba.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,yeah.net:email,mail.gmail.com:mid,cosmosbay.com:email]
X-Rspamd-Queue-Id: 5CB6E28EB8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 8:40=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 12 Mar 2026 10:54:06 +0800 xietangxin wrote:
> > Fixes: f2fc6a54585a ("[NETNS][IPV6] route6 - move ip6_dst_ops inside th=
e network namespace")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: xietangxin <xietangxin@yeah.net>
>
> The Fixes tag should be:
>
> Fixes: 0287587884b1 ("net: better IFF_XMIT_DST_RELEASE support")

I disagree

What was the situation before this patch ?

I think virtio_net has been able to hold skbs way before
IFF_XMIT_DST_RELEASE has been invented.

Some archeology :

commit 93f154b594fe47e4a7e5358b309add449a046cd3
Author: Eric Dumazet <dada1@cosmosbay.com>
Date:   Mon May 18 22:19:19 2009 -0700

    net: release dst entry in dev_hard_start_xmit()

But really at that time struct dst_ops was not per netns

The bug came when each netns got a copy of "stuct dst_ops"

Not sure if 'fixing' virtio_net is enough. We really need to check all
other drivers that might hold skb with dst for more than an RCU grace
period.

Or... not count dst anymore. What is the point anyway ?

