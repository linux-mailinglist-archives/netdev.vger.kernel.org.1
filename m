Return-Path: <netdev+bounces-301757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 933jDewjPGrJkQgAu9opvQ
	(envelope-from <netdev+bounces-301757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 20:37:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6296C0C3B
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 20:37:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="RO9m2As/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301757-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301757-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4093F3002D01
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A7D331237;
	Wed, 24 Jun 2026 18:37:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDD73093DF
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 18:37:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782326247; cv=pass; b=C3uHiwqGcVUpJzBtpAki/cwaMSjB6GWYAddR4KNZ8xkujE3TN7IAqo5Vw+HMY4yo+BvJ0CdzbZNnnznvGtzjxSch0yvlSuRmfH726w9Vn1Sg3nhTdhnWCzGHASWrvuG7gAvr38VloIizbz/oEdMqDOzZkW8yTRuR0yQUECvK+6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782326247; c=relaxed/simple;
	bh=p0SCwS7YCFgWfir+jQAsZ43XLLQbWbsHRRvkRRKYAgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kf2Hmz0pANRK33Ny9OpRjyj440w6wjkCMlk0ix/ev2jez3FGK7igc8ni6D41NexqpSaSghZqFWVXdQX29IrskF1UB4ekBaen6ZgNdOFegLxjrFco3Bp9Td/A1BreWX9Krt+gg/xqTC6BtM/0Po8ISCrydYwrPkRp3OrQ8P310do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RO9m2As/; arc=pass smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8423610ec93so1593198b3a.2
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 11:37:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782326245; cv=none;
        d=google.com; s=arc-20240605;
        b=jekjIVC9epU3zsnH+radquaJ4V4qjp2Jz+dHds8V2qBZGYoRfO8KSBLyYFQth/IEiH
         FLcYd8qhoWBudpvr5TnryN7lp0awPyu/EXf+CvJiaV6VMvxOIEn5bOhmoiOxOohDLvS4
         Z2+e49tbehC2APiBh17tD9RtLOFSiVfN6aX0qVxQEj8jooFHif+4Qy37cT7ZWeBw91UC
         +LvxefdAt5p1hEOHWdo1cDlRt58naj/PbJ+glmul9WP3+5emjcNj8pkOtk+7Su57Cvks
         5PPpAoRx6KZy9bn4NduJWdDLdzPrRUFpC3aEncPmlNVb5q3JfFU2SN5+pRj2Ajq3pdla
         kvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=p0SCwS7YCFgWfir+jQAsZ43XLLQbWbsHRRvkRRKYAgg=;
        fh=00oJbIKGkd69+DDThb10RxpLWnvvQCatRQLYAUC3XRw=;
        b=R97Qepps3covLmfePLetFsv2bT9XDlHKHAU+qVivHoct02jhemEsDkbZWEmr1NMlPO
         hyZPIPgaYhccS8qjZhrScuLJojd7OrKTyF6h+RGr5Dei33qMpaYQ/V5V0kmULER0Csne
         2ac9ZFUkGXRsGWnh0bPC7rfZLTvKw3+7Yw/UvL2tweqt09KqGqAR2MYlqugFjIAI3o3r
         FGBPRJ1BlnCDzEEC1LVf90kPM08ukxBWzQKrAME57ANTFaeIvyvAFG6M4cYJ5dWkhgwJ
         712XM64ke6TjHeN6g9jCjiI3vpAgPAH+tWLmZmzNLlDy7DENgj5weEpUavviUg990UrV
         segA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782326245; x=1782931045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p0SCwS7YCFgWfir+jQAsZ43XLLQbWbsHRRvkRRKYAgg=;
        b=RO9m2As/jZ3n6EyumLntMEzldJ3CdPn93IRNMjlGFgH4okL3testvCdc5HdEzIbkcC
         NTLGLOUj9/GlDNlM59FF32GzBapSTvw4sbnOyA/EaKniOzRsAs5NEGgfgxv6UKDvPWos
         /gOEMt1/4Q6r1nVwuqT870sY7+jbro5/T2dmLmhv990fG2QmbFWQZExww2kVaMxYfsB1
         9IU3KRuys5bXbQsvhKoGvjAsG5WXNIkKJCthszndpYBkG/pxihnGurj+raUHy1I3HrJR
         aX9wv+ELOWWpJUkQV6uY0RTKjwCZVr3xKGScOkSUaarv/Rfl2DvzQP0gC75+PFSd+UE+
         urAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782326245; x=1782931045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0SCwS7YCFgWfir+jQAsZ43XLLQbWbsHRRvkRRKYAgg=;
        b=QjySsC+p4VY89YCblj3nEwA5i+avsTfiL12A3W12RU4iYlgWah4Nmmcn4YTRfugjFi
         RLNrLPtL3UO9LMb+OkGpph9Qceq3kW3/W+OLy7FJeaThk8KeveeNTHONJyhqRA7Lm6/E
         R4jsGORn/Avqp5vGLku2sHrM/SQ18wpQqOGeuK2McT7kEgKlq22TNfnI7CWn2uFgOekK
         SV6XEEFDOBChJevykGsSJ9PbSU1VqA3+4+oGZmSzv78wIPoL2p1GxNpnTSzHsXcgBRX1
         vWeyUrF2mtrPD4QmzCLJ3KX0gLdKb3/DEL2SMCHxGNdtC2A6MY1DDkojmYRT5jlfOLK8
         4s3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqdemj4K2RQzVQur7QIqxUMNeQufaLUs6OviLdAhriGKLimZlZ1Cf2zDgBrQM1m15TowIRP/mI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7srPpKlC7fufMyy4TnYo3uaPJyyjQaauoJuLPvcpE/hMxmVac
	xjEszE1QvN/iQK+/osbXRzZcBb85h1WkW9dSIsUTXI7mhJaMGrtU75hqmJGhHohVAQdM2oZM8JV
	N8MfRPcPnbif32roKFtijETlYgAlg9q4=
X-Gm-Gg: AfdE7cmBWwyRPkrw+kFg3KNf27MJ3vYp/pZFl7cKtzFAdBcxqDcquCkrfobv2dPTtZH
	NleC8qVYaECHjiGCW7ZqNLaGtG4+S2HmgcPCeiQGvS+YZQGWtzop6sl4EUxV8mFCCU711BXGSUX
	UUSSt5gNrqovhl1IYpmpECQJkcniKf/Rb/nTcb4KX0K1l7dxda62xsCiHcWHlRP3hA8bS6etP6V
	rS7G8AnswrCnGU6OLUamxJCtooG/qGWLwtTBuJ63v/GuEWjGA3QnE4nhUZqoIXuQ3UeHyCjdIzY
	k+AIJbGQrIXsLCIv+DlNtQuhhI6dBJfZozhq9kCcdyeTNF4mId2hLUTAUj5eVQlM/ZnHLKnx
X-Received: by 2002:a05:6a00:f89:b0:835:532a:3468 with SMTP id
 d2e1a72fcca58-845a2c015d8mr6027368b3a.20.1782326245270; Wed, 24 Jun 2026
 11:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623173030.2925059-1-edumazet@google.com> <20260623173030.2925059-2-edumazet@google.com>
In-Reply-To: <20260623173030.2925059-2-edumazet@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 24 Jun 2026 14:37:13 -0400
X-Gm-Features: AVVi8Ccw1S1QJLu9sk9eWe-uQ2Joyqa1oNTy13GBzL8NmQ14GUlwDZyc6zz3SK4
Message-ID: <CADvbK_cnZmZkzCUxGEi=uaBug3VcfUd4MiAzQp1OGUsnvau=xA@mail.gmail.com>
Subject: Re: [PATCH v2 net 1/2] tipc: fix UAF in cleanup_bearer() due to
 premature dst_cache_destroy()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Jon Maloy <jmaloy@redhat.com>, 
	tipc-discussion@lists.sourceforge.net, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-301757-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lists.sourceforge.net,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:jmaloy@redhat.com,m:tipc-discussion@lists.sourceforge.net,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e14bc5d4942756023b77];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F6296C0C3B

> diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
> index 988b8a7f953ad..66f3cb87a0aaa 100644
> --- a/net/tipc/udp_media.c
> +++ b/net/tipc/udp_media.c
> @@ -803,6 +803,14 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
> return err;
> }
>
> +static void rcast_free_rcu(struct rcu_head *rcu)
> +{
> + struct udp_replicast *rcast = container_of(rcu, struct udp_replicast, rcu);
> +
> + dst_cache_destroy(&rcast->dst_cache);
> + kfree(rcast);
> +}
> +
Since this adds a module-specific callback rcast_free_rcu registered with RCU
via call_rcu_hurry(), is an rcu_barrier() needed in the TIPC module exit
function?
If the module is unloaded, the RCU grace period might expire after the module
memory is freed.
net/tipc/core.c:tipc_exit() {
tipc_netlink_compat_stop();
...
pr_info("Deactivated\n");
}
Could this result in a kernel panic when RCU attempts to execute the unloaded
rcast_free_rcu function?

This sashiko report looks legit.

I think synchronize_net() doesn't guarantee rcast_free_rcu() to be done.

