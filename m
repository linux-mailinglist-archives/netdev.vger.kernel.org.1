Return-Path: <netdev+bounces-298895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dqrjIAvPLGpdWgQAu9opvQ
	(envelope-from <netdev+bounces-298895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 05:31:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B0467D9BD
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 05:31:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=PmrNqNSR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298895-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298895-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DFC83100605
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2C3349B15;
	Sat, 13 Jun 2026 03:31:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE21B983F
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 03:31:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781321478; cv=pass; b=BhrjnlJ2Cwq1uJvz5IL5cA6hzBEjKzJYieWba0gdX0Z5r1czjZWRRdQvhGcsx79UXxcPAi9kCRq9cLynZKb/Epo9Hukk81GHPSSHAFhTE3yBisl2WmIZ0KbMxZiUehI4n8hlcMASc/tYYJeUPnAOFH6bKyUCWLg/rozSLARoEc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781321478; c=relaxed/simple;
	bh=ZXDZnM97lD4Z3x1nQ8IPpOO2DiE1spKw7zbCMMKqgBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTokhE+W86ySMQGVkw+wZC8apbo5DLkU+VIMxeGFeSrI3m3ZrkHWP0FQcgQgi4yb/7QRH1bHn3OWQVNtnSLstVibGmXkC+cxvs8diXaSB/2CnhQ6T+pRMelGhsJXhCZqsBJGqHcxMlNDZcBKNRGIBOMA9uUoDkqP3JCXNpbnHQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PmrNqNSR; arc=pass smtp.client-ip=209.85.219.47
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ce9ddeddefso18525456d6.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 20:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781321476; cv=none;
        d=google.com; s=arc-20240605;
        b=TH6siHzdvwlV7FLOVHli4Nwhy0o3Evo+cOSXuLp4HPwgmgNnrlfeDr5SVvUzc4a0Ba
         8GmqR/yPOKWgP8p2xZJyhNTb5gRw5eQbUanC9HVVZXJnMFOh9sXLtBbabOut9/6VRNcU
         NQyB0aYhHOjMCUCUkpA8xV/pKQvJjZiPui19dq22tnJzRZg6RNkzcoZssmG/e0cGILz8
         H7resnd6RUzHo62JMc6C8A+rgvH8FMfqKrpQ/0s1VHU3F1bt+GxNMJFDyASkLYrfUzsz
         83MCZH0xopwYDh1zgbRtQ0og+r4TQN43sVJFTkbjv0YfQRlCb4ergOJ0VyqMfEY3EdNo
         qRAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1N+Y4+Ebz5eq2rs04g2NhF5lcNLQs+3vWd6IbiqVT5U=;
        fh=cOIVU7FCbEG6jgIXAa32HljQQVGeA/iLsj++8gScUEI=;
        b=UQnFxw412YZwwAcSwVOnxQ8FwHF7hBBLRZ3EvfZr7WkOmve9+Kr+LgLnGqP2/odWQy
         ZIY6Qm4ytUP9oQ5cweFqlX07bFw0xG5OA9qxpO1flP/pgGnlBElN12+5wu26kFFp0UAs
         N08ssYtSpkcBNn8+e5SMVTrj3yc0YBaOliKhVjxuX5dhrVfSV5mwS3Fg59TDrOudD+8d
         LEFKEwdHMVr7p1vEKqLBjVe8rFbiXZdlfAz7huOWvAlwa013XQiRwmlC1grAoYRplKdZ
         5bid66xGilCYq7zdX65/a6ISFe/wQ6VQQC/l2NjBwqf9dRukYyLkdAu337XLY3H7xZoK
         6l9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781321476; x=1781926276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1N+Y4+Ebz5eq2rs04g2NhF5lcNLQs+3vWd6IbiqVT5U=;
        b=PmrNqNSR2PCKf2RzWrqXOrxTHQ3OXM3K4H/B4iRNIpGUgrCb/WzfOw5R+8rk1Bes9A
         ZpE9TU5bvVAZe5BmZQeS9fPlfHoM9VWbMzyrV2qNpptAJl+NwSnnVStBIkT1ZJdav5ER
         h6kp7yX0kGxO2rhP3MdmrEZr+Sr4Wml4QA9UrXKHgsBqYfN1gKgEUrRVEi9oXAU8Q1Xo
         kLVLymOjHW3g9LCznUZ+5FmA49PM9NlFaO20I4qcJLSL1LJmpRSkMBSeoAsyF/rtbSmz
         MGgqpYp7zQAwEdIEYwg3zxAv251q+x7sZ7dRXKf+u/SqyVw9FI97HfBwqtQ2g5yGOMe9
         J5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781321476; x=1781926276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1N+Y4+Ebz5eq2rs04g2NhF5lcNLQs+3vWd6IbiqVT5U=;
        b=GXNIJePNrWFyPj+MaycA1kOHj0Rx6hKzORkFRkgNn3waeII6Gy0r2byDz6L4YO3MCH
         pMFpwIKzWSvvIidrAxLf2LLXniEd1aFQf70lZTnKFZCD6bPm9kD7Zn/jmpreahuE+Dc4
         bkX5aPAyxILYqVEn5kSC+UkbEg/JZOvxZvLC6JsNOtLfB8/RlNzurJ79FYC0ZlP9w0gf
         ruQmD4z/+X3t/NnDQuN5XU8rOFYiv5k5OXNp5ns8ycK/M97qmyGTCxbuIzqivPQ/A4I+
         SIq7f1wFL0w4ES94xGpgHbAk0h50C2P699bQ0liJ9uLj8NBN1YesfSxoG3o5cECI9cC5
         TqkA==
X-Forwarded-Encrypted: i=1; AFNElJ/hg4isZv4S6puWm24Y+0UdWQGWMNXLJCuXOE8WSmmtTxabgbW/pjTYTHDFsssh410/ok8o0gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYujc/Mi8xlKHBUzTc57E1YoH6zy8+7YnZ5VtR9k2hazyzLYoR
	uFocCoFKfNYs0KymOfNPcHyGZa48qnjFK5mny3CW2Py+jGBMdF4GNZ/xDMtJjBxCYzdWbn1O7Ta
	uiYnyl07m0g9AQ2PY+uoVkehJZzhNgAm1X8TrWN63
X-Gm-Gg: Acq92OE4XwtOzcovC9MBeive2RxkXbl+VC66Bi5lYONJiW1yi0FIFxVzmuz874ptMv0
	GSKUulQCpKCRMNjQotiUTv4bCvqkzZvGdsfYwYo/jUn9sLuxVXrful4WwSwlEO5yxf1iduyo5O7
	l0GvoW3Fc3QZChC1fXrRZlem+/HuKP4e2FzbpkOACJNF654p+Q5xNBFB/oA2oJ4AlkknXyP+5ZC
	0hijR0eaArDGFI0ca6FLtEgfRT8eElPTQdEuQP1azpwhFX+J07tgB/Dsspd1BHfEvBsQAdD4MAc
	rniz/enu9k/6FCEFnFr8FgRl43s6kMECoAaAKujeML9rhvz/fsabuHl8PsEqW7Wkpv52mYECkQo
	WBmsbHL1MSSQlct9E2RI=
X-Received: by 2002:a05:622a:6207:b0:516:d955:ea2 with SMTP id
 d75a77b69052e-517fddcb3a8mr88521351cf.0.1781321475703; Fri, 12 Jun 2026
 20:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612135949.4010482-1-edumazet@google.com> <GV1P189MB1988A0E785BF302589C9AE42C6192@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB1988A0E785BF302589C9AE42C6192@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 12 Jun 2026 20:31:04 -0700
X-Gm-Features: AVVi8CeThQtBBgXWv8O_Z4xhJRfnyhNeL294dlY0rv1WIkggI0_XNWOQRDYAp84
Message-ID: <CANn89i+=e3ZNDTXkB7pxYnbiaw50Y=WgGbw2WJM5__1XjSxU6A@mail.gmail.com>
Subject: Re: [PATCH net] tipc: fix UAF in tipc_l2_send_msg()
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, 
	"syzbot+64ec81389cbad56a8c35@syzkaller.appspotmail.com" <syzbot+64ec81389cbad56a8c35@syzkaller.appspotmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298895-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tung.quang.nguyen@est.tech,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+64ec81389cbad56a8c35@syzkaller.appspotmail.com,m:jmaloy@redhat.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,redhat.com,davemloft.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev,64ec81389cbad56a8c35];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8B0467D9BD

On Fri, Jun 12, 2026 at 7:50=E2=80=AFPM Tung Quang Nguyen
<tung.quang.nguyen@est.tech> wrote:
>
> >Subject: [PATCH net] tipc: fix UAF in tipc_l2_send_msg()
> >
> >Syzbot reported a slab-use-after-free in ipvlan_hard_header() when calle=
d
> >from tipc_l2_send_msg().
> >
> >The root cause is that tipc_disable_l2_media() calls synchronize_net() w=
hile b-
> >>media_ptr is still valid. This allows concurrent RCU readers to obtain =
the
> >device pointer after synchronize_net() has finished.
> >The pointer is cleared later in bearer_disable(), but without any subseq=
uent
> >synchronization, allowing the device to be freed while still in use by r=
eaders.
> >
> >Fix this by clearing b->media_ptr in tipc_disable_l2_media() before call=
ing
> >synchronize_net().
> >
> >This is safe to do now because the call order in bearer_disable() was re=
versed
> >in 0d051bf93c06 ("tipc: make bearer packet filtering generic") to call
> >tipc_node_delete_links() (which needs the pointer) before disable_media(=
).
> >
> >Fixes: 282b3a056225 ("tipc: send out RESET immediately when link goes
> >down")
> >https://lore.kernel.org/netdev/6a2c1007.428ffe26.258b27.015d.GAE@google.=
c
> >om/T/#u
> >Reported-by: syzbot+64ec81389cbad56a8c35@syzkaller.appspotmail.com
> >Signed-off-by: Eric Dumazet <edumazet@google.com>
> >Cc: Jon Maloy <jmaloy@redhat.com>
> >---
> > net/tipc/bearer.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> >diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c index
> >a3bd1ef17558a37787bb92f2c3805c0fda874d8a..05dcd2f9e887a6e5ca6665ab4
> >1e4d5b5107f158c 100644
> >--- a/net/tipc/bearer.c
> >+++ b/net/tipc/bearer.c
> >@@ -482,6 +482,7 @@ void tipc_disable_l2_media(struct tipc_bearer *b)
> >       dev =3D (struct net_device *)rtnl_dereference(b->media_ptr);
> >       dev_remove_pack(&b->pt);
> >       RCU_INIT_POINTER(dev->tipc_ptr, NULL);
> >+      RCU_INIT_POINTER(b->media_ptr, NULL);
>
> Since 'b->media_ptr' is reset here, Should the same reset be removed in b=
earer_disable() ?
> bearer_disable()
> {
> ...
> RCU_INIT_POINTER(b->media_ptr, NULL);
> ...
> }

We could, but we would have to add a reset in tipc_udp_disable().

I thoght it was a bit clearer (and less risky given bearer_disable()
is called from many points)
to focus only on tipc_disable_l2_media()

