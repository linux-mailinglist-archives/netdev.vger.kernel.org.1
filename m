Return-Path: <netdev+bounces-302670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S5XGIq1+QmpX8gkAu9opvQ
	(envelope-from <netdev+bounces-302670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:18:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B806DBF01
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:18:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OeOwTVAE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302670-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302670-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E75A3001FA8
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268D5349CE6;
	Mon, 29 Jun 2026 14:05:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B532634BA5B
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 14:05:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741912; cv=pass; b=KRWXQYbfF6HBAqu3sygqX6OGbhCrIy/NSInOTPNHL6792al/AajIBIjN2Y8CRFeBp+d7WjKh1We8/4FBVoRDebTao871hNtsNeQJ+Srdk9tXA3F3l3+636YGyxAL0xNj2p47iRWKizrnEKHZF3DRXY1rDjIiIPRm6NOnX1kgcrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741912; c=relaxed/simple;
	bh=cs1kPtPPS19ArMNxPNUYHq/WmdH96LCYU5yr3oE4dOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8joiWwBe1fMcQO51ZJF6MuZrXXECQdyUPL8A1z+iSNg6Zfp6LPHtbJutQeDlK9MB4mdds//cJuEvKVXiKOdRdeOrkvNe9/usNQEWi+8da2UUEFAbO0Mf5X62GUv643XKCGhU5hu3NoCS822Gay/uyBFo2D4t4lZli6MfDcBsAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeOwTVAE; arc=pass smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8454160043aso2790689b3a.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 07:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782741910; cv=none;
        d=google.com; s=arc-20260327;
        b=sZ5ldJeEGccZzy16bxgXssbGeX1SRRy2wsM25gbnEq3RCFXSILS8fF+2EqcHHnwea0
         9baRAkCQ7orjDQFIA0wviw3cCVnIfRwTScOXOA2NkT264dp7nwKyDEN9KYGZjwxCzyyO
         Plil/04fLtqIl7rrs2PTkjHKpQMp9jUYP0HodUqgtAVooW4HDqbbBED3TgSdCrgrQJ4y
         jhpRKgeAfPwUDqHtpBxC5A5DgRo/L5Or0nnv8A73vMV7kIQMlxnWMqtVlh0Zw522MBFI
         ab9sXq1ckRaiNQm5/HvGjVw77cDJIru59NacEzxVu+rhij5CSmNGDnmR9BFB3uQFVF+G
         J1sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vjjrnHH03TsaWfGwzNnjbGQph+TjFJTi5n3JvZIW9mk=;
        fh=+Ga3bOd2XJdkMFV+wionaHpu+e87XmhBTkej5XB0kRE=;
        b=g8yPJrsjeWIUKpY1eGwN1YzZY1QWGlAW6aLJeY/fR2/w9YjlZiYMbP8NB8iDrbVL2G
         FZfcskGhmuP1/MRMQdr7Juhw3KhqTE28liCrxOVR0KHgMRyci5LjxtuG+OVCPYVPcPc9
         v5nEDW1E/bi4cBG9EkcGybbldWJuo2ZUT5JJ+xhaJkJAGkLq3ZUh1yoU05216I9ZUYa8
         gsCUkZgqCaBQmQev3vMGdVO23DPbl3ncjzCN7EuDtTqk51mALLdLYuD5o5jLB4ssK/GM
         xhNiSpfeYM61klLAukCgk9KPDbjWdcwPiqhH7G+ggJV1voN2FfqNEigOGjGo9t8uiTVF
         cxtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782741910; x=1783346710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjjrnHH03TsaWfGwzNnjbGQph+TjFJTi5n3JvZIW9mk=;
        b=OeOwTVAEyW4WN2zX23C8Qll+fVhXa4EH7hfA1XRlHwyjxKr0JgfdNna2o+MsnYcSrG
         kwEwjx3hhNQh27UGDrJWIEZzWPOdl19FBNlk2lJl54oxSq3wtsmC5tSPPobTdcZY8hVs
         yBFhkptkQP2sHmnw9qw7w0yftGS4ZCpcrClxN0GLzwCu2DcZ9R4EicbujXua/gRpI0sm
         wgKwcZ9oxrfjhP7A7WzT/Nt0cDUa2dNJOIQKoX8RbsrfGa4IwGIPX6PJ+qOiFe6CcfzU
         HsVn9YK68ek4PC/hXck6ksVr2WYa2HY1jVNYdo+cqLWZjwDvnY6rPma2/X3SrD3Ga7J6
         qMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782741910; x=1783346710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vjjrnHH03TsaWfGwzNnjbGQph+TjFJTi5n3JvZIW9mk=;
        b=f8XFA1DZEasTL+CxbbJ0AeGywx3KLYiEjH5pFSXQiautUmOx/UZ7ob2TESO4/qLrVz
         54CMcNwxWtA5Ci6hQkhU28syorast7waLz8jKIDMdYM4zQcQsEL32fqngp9NLmZ/bd1p
         cKKWY5b1iPuF17mkL4sAbc8PxGKJfzRPPnoV6kSkZ11KL2H9cILa7y+86ax6pYUhRoF2
         LixN8i2ajJkpGSgcorPFpj/zj5M4YScBQVmiKqCWdZLfB9+i9SLqZO+MkTf9YMzT3lg5
         52pFYTonOfwkd2FSuyhR30DhBjSnsy5TwVUQB7J8XubTwGUrygWsYtqHuENy9DqcRbh+
         89Pw==
X-Forwarded-Encrypted: i=1; AFNElJ//ZAkARJLZZE1KS9ZMJOxCFseZv56qLCn9J2XF9OTg65eXLIzUc76mXrSCkMdG8351tigNIaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm9V42CHHJRZeA7Z6R83ot5iUxP/jaPwj6ReXp/wHUfOA8ArB7
	QhFKESxQmMzEtbPnuyoGvL7N2ENxmIhZUmAXE8dvWCsJJz/yE3DskEQtZ6EY6u/4t1Y2x4V/mdS
	b9tW1Ummo3tlaxE+84+TEZ7BKZDhGm3o=
X-Gm-Gg: AfdE7cmt0dD6gddHyEO98YnGNwFj42TGeWMx6XTmBR/xKuFkSpXBthIgoBYAPeFFpA+
	poEROnhAKDSoXyoxAFHD94FgR/Pql1qyOIPtA1BuEN+7qQ1dFVsY2YynqVUk6rkYDGBDzXGyc7V
	VYtbUg4RtrR3DxoINcyQes4Qxuxg1Q++C/sUqCBRPkTPve7Whs1WL7HjVbjAGpLAo+yD2paz7w1
	qJ/Q/7BLQEldU6aL+zoUnF5JiqwYaLqV03Cqbc81zXvu/lBRCNN8WHx0kUdo42CJE/+TOWp+rAq
	TmjSMut5LQWxcTU0WXylSwO7AOGiCEsOwbZrctqpbyf2DlL6IEXlyfhMqbY5RFuD8vql3Co=
X-Received: by 2002:a05:6a00:2383:b0:845:e0ee:29ec with SMTP id
 d2e1a72fcca58-845e0ee5b0amr6169787b3a.35.1782741909891; Mon, 29 Jun 2026
 07:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782585631.git.roxy520tt@gmail.com> <b9f1f02b0780ad6a719e2413f5f0bb8eb7702d94.1782585631.git.roxy520tt@gmail.com>
In-Reply-To: <b9f1f02b0780ad6a719e2413f5f0bb8eb7702d94.1782585631.git.roxy520tt@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 29 Jun 2026 10:04:58 -0400
X-Gm-Features: AVVi8CcY3NR_-y9qUrLG5IFlanrznpuFWa7VkDonL3QllR3_TapyoSkskTidgUU
Message-ID: <CADvbK_cYeewNprxJ88TdRnCr2QTh1px8vxdqikBovb+dTEtp8Q@mail.gmail.com>
Subject: Re: [PATCH net 1/1] sctp: avoid auth_enable sysctl UAF during netns teardown
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, matttbe@kernel.org, yuantan098@gmail.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn, 
	roxy520tt@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:matttbe@kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:roxy520tt@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302670-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,lzu.edu.cn];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79B806DBF01

On Sun, Jun 28, 2026 at 4:40=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Zhiling Zou <roxy520tt@gmail.com>
>
> proc_sctp_do_auth() updates the SCTP control socket after changing
> net.sctp.auth_enable.  The handler gets the per-net SCTP state from
> ctl->data, so an already opened sysctl file can still target a network
> namespace while that namespace is being torn down.
>
> SCTP unregisters its per-net sysctls from sctp_defaults_exit(), but
> sctp_ctrlsock_exit() runs earlier because the control-socket pernet ops
> are registered after the defaults ops.  This leaves a teardown window
> where auth_enable is still writable after inet_ctl_sock_destroy() has
> released net->sctp.ctl_sock, leading to a use-after-free when the sysctl
> handler locks and dereferences the stale socket.
>
> Unregister the per-net SCTP sysctl table before destroying the control
> socket.  Make sctp_sysctl_net_unregister() tolerate a missing header and
> clear the saved pointer so the later defaults exit path and init-error
> path can safely share the same unregister helper.
>
> Fixes: 15649fd5415e ("sctp: sysctl: auth_enable: avoid using current->nsp=
roxy")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/sctp/protocol.c | 3 +++
>  net/sctp/sysctl.c   | 9 +++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> index 587b0017a67d..ae381d304bd5 100644
> --- a/net/sctp/protocol.c
> +++ b/net/sctp/protocol.c
> @@ -1457,8 +1457,11 @@ static int __net_init sctp_ctrlsock_init(struct ne=
t *net)
>
>  static void __net_exit sctp_ctrlsock_exit(struct net *net)
>  {
> +       sctp_sysctl_net_unregister(net);
> +
>         /* Free the control endpoint.  */
>         inet_ctl_sock_destroy(net->sctp.ctl_sock);
> +       net->sctp.ctl_sock =3D NULL;
>  }
>
>  static struct pernet_operations sctp_ctrlsock_ops =3D {
> diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> index 15e7db9a3ab2..fca840484ebf 100644
> --- a/net/sctp/sysctl.c
> +++ b/net/sctp/sysctl.c
> @@ -615,11 +615,16 @@ int sctp_sysctl_net_register(struct net *net)
>
>  void sctp_sysctl_net_unregister(struct net *net)
>  {
> +       struct ctl_table_header *header =3D net->sctp.sysctl_header;
>         const struct ctl_table *table;
>
> -       table =3D net->sctp.sysctl_header->ctl_table_arg;
> -       unregister_net_sysctl_table(net->sctp.sysctl_header);
> +       if (!header)
> +               return;
> +
> +       table =3D header->ctl_table_arg;
> +       unregister_net_sysctl_table(header);
>         kfree(table);
> +       net->sctp.sysctl_header =3D NULL;
>  }
>
>  static struct ctl_table_header *sctp_sysctl_header;
> --
> 2.43.0
>

Please also move sctp_sysctl_net_register() to sctp_ctrlsock_init(), and ca=
ll
it AFTER sctp_ctl_sock_init().

This is not just for being symmetric, but also fixes two problems:

1. A regression caused by this patch:

If sctp_v4_protosw_init() or sctp_v6_protosw_init() fails in sctp_init(),
there's no place to call sctp_sysctl_net_unregister() on the err path.

2. A pre-existing issue reported by sashiko-gemini:

> diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> index 15e7db9a3ab2e..fca840484ebf7 100644
> --- a/net/sctp/sysctl.c
> +++ b/net/sctp/sysctl.c
> @@ -615,11 +615,16 @@ int sctp_sysctl_net_register(struct net *net)
>
> void sctp_sysctl_net_unregister(struct net *net)
> {
> + struct ctl_table_header *header =3D net->sctp.sysctl_header;
> const struct ctl_table *table;
This is a pre-existing issue, but I noticed a potential race condition
during SCTP module initialization related to the sysctls modified here.
During sctp_init(), sctp_defaults_ops registers the sysctls globally before
sctp_ctrlsock_ops allocates net->sctp.ctl_sock:
sctp_init() {
...
status =3D register_pernet_subsys(&sctp_defaults_ops);
if (status)
goto err_register_defaults;
...
status =3D register_pernet_subsys(&sctp_ctrlsock_ops);
...
}
If userspace accesses the sysctls in this window, proc_sctp_do_auth() could
dereference a NULL pointer since it assumes ctl_sock is ready:
proc_sctp_do_auth() {
...
struct sock *sk =3D net->sctp.ctl_sock;
net->sctp.auth_enable =3D new_value;
/* Update the value in the control socket */
lock_sock(sk);
...
}
Can we hit a kernel panic here if the sysctl is modified during automatic
module loading?
[...]

Thanks.

