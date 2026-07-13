Return-Path: <netdev+bounces-307248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DLsUNXITVWrajgAAu9opvQ
	(envelope-from <netdev+bounces-307248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 18:33:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4749F74DA41
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 18:33:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YXJ4uImu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307248-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307248-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74AB3301CC55
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4D633689A;
	Mon, 13 Jul 2026 16:31:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F367B31A572
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 16:31:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960280; cv=pass; b=ZuGB9Ub3WhN2nAW+WEuQAyL/0CQ3aQyVMfl9NB113Zb7a4pJNK3I+v3qiEqXEdNXW6oHfqQ12KWSS5VZ0Nf9QB9wCVb8S9AQ+NbjKB6VlyLnbVO1lx2734hlmm+mZbdlAPpJp+5QOZy+a/2IW8YrediGTUK/lC5C+RAPJV+Jqlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960280; c=relaxed/simple;
	bh=fMXUadaMlaw3f/HyC+taB9Yf9rBd1Xccd6+qK3lbMYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXbt6Mua8VrRWshzX9EfrF2V0KelktZKteeyzE3t23pZY3r3EV7M9sO80iUJ3lKHG1sOC3ufqT2RS2wOPoD9uNuWeY1A/W67JdWaNjbfFvpIyAs0PtciVqyTZsbh3WRYoh0SGg1gyML6JK61e04Yr4LETinjBAo6XtV+VsZqtoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXJ4uImu; arc=pass smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso3474359b3a.2
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 09:31:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783960276; cv=none;
        d=google.com; s=arc-20260327;
        b=SPM/ANFSIubbS46BKOZTtTpcjIVRSDyH5zPiuDqcTiyAfcRE4n6QuSN6FDjFiJuU6V
         kKlX1qcSL0ih7vMvziHlgOCTmkQLyJZAPql1s4UuCCkEr62PhqnxIODndCbnL2NMy2Xl
         HZgfqXfPuWHN+82gOuLdw7UnvN0pmlfrp60yoPlW4l/+LFCV6orjaAQwpkSB6YbCh15J
         vTEOaJQMiqiImSGzypPA+onjTIeLT1nNtWJS9V0EfEpvr/HgYAutCT9VWzVQLwDUZ7wa
         1w/dJnrdZNFjV6SmCLedbeRhUL6W0PlJMxgE5qWh9eSKZroKJsLwwOBq/tsmARPt/hWW
         r60g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+bwa9pydu/8yllcsYkRiPfAlJFcYCzuXVpbQP5Fdsb0=;
        fh=TmChixdZLCuLx8DiZ+CtT/pawlkrOExjtgGalrZH1Vo=;
        b=XqMVsp4c8pnXEZ3IeRtRnRCYmYSJ8yq8WZZ4nXG1eF64obsDuuHpQHHTh6K6ONa884
         KOrx5JJ0+6t9f2JXiRBdHPTRqnxEtTaLboyfk7i3kkiRoHIX5aeM/2WJKuf22PP+mbM7
         RM3DEBTZOfSXf6jEc4W8P7KfR0VXoebKleDz8H/qhGGkRuhEnwCSwMseihceIak+JcLf
         UlN9bMrfU5P2j0FSRqr1fxHacsqBp8TRw1snJYnR9AavNHXlKZU3leeO47tD9mx/EOeD
         zO1a2d0LAw9Z9MYND2TVaFxbQVKqz1cZDAP7tGlizRjvd5grJrjRj1be1R3n3pw9q32y
         HCkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783960276; x=1784565076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+bwa9pydu/8yllcsYkRiPfAlJFcYCzuXVpbQP5Fdsb0=;
        b=YXJ4uImudMsY2qGMusnjw5kktyB9diyCRw9uIkmWcd1FAxch9NztvxfZebNdvftv5/
         zOBw/PxRNVPP9VDtOyp0UiB0QiU9XoQgfL7Nvsh69cPFKPdt99EAxxGdr3+kh7Ng0cWY
         +hSaum4Srx4nGMsXzCu22WBQvIqOMDH9/7u5CR4fvBPLiszXUZKqm6yJlvUfIgVeSFkQ
         GF5MOpgxeZtu3eISiIIW5xzWRBx8UwBLyk+mVNd4arh817Am2HpvRoI7eRwnZ0P6TwX6
         xyFPYDaNodpp9zGI3L1GWn4LfCjyLH3xZ/JrnRtG/f2Nu7nsjk3uc3w/wijQ9XQsN0MN
         pjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783960276; x=1784565076;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+bwa9pydu/8yllcsYkRiPfAlJFcYCzuXVpbQP5Fdsb0=;
        b=ki6j69hnyQFOdKz7sppVWtNkE11TUFAjP/aSfgKRMVAwSkjZt4EEo8W1oDeiu2GaSZ
         dciPvJgJKWiQ+7WOsz4pD1oUQw8fwdEAboy/cLFtpT2W3ruklfIFuEug7MqrYDaIRpB5
         RMHG3jdaFlv3VDqUjt1egwBEfKaklEkUebD3mrlFrURyw0ux4j526QhZu83XHcdKIqQI
         nHS7Ns/Q+KgUglaVUbc3XbMUqKzT+uAGVilNA6HmHn6+MZs9kZGYfYi+GPkYJZznxcP2
         E8bxxYXzpz/MDl9EdjOiLIBwkBMBsr1nnqHH8OnYT936oR4pwkPhpyyvA3+u2O56hxG7
         WttA==
X-Forwarded-Encrypted: i=1; AHgh+Ro2Am+OajhziLxAgJX8w0EI1X0CodEJCtlSy9Z9gbq8ItU84e5m8QwVSvLZPbcuYdfnm2Ier1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5wqILY4xybXbbSh0GpPD5SlFGy2FEolioq7zfEXEf9ZIeTz9M
	HImPrA8xSFGyHe/vJ3UQn0nxMMoWjOIHXgHnj/wTuWMk0h28fyKREtNs2pQnTUn92k44RBQTtKX
	ycyZ8ZP/6ZWvZYb7MQxIxitmqD98S6ao=
X-Gm-Gg: AfdE7ckpLZRyc5amThGes7exe4kvjORfEatUPeLT+fdxFvjMAx89ruUSvxiEo9HzeeF
	kob63vnv+YXjHRMvK5kDVsD1eT9uiWQigZJ7Rw2/x2koQSH8/LzmIi+ko4hBqgvJ2hxaCAidU2f
	Fg6UUU5264hBpSRvMZQgX2VYCfzt/zFJhFm10J2QMZIkV26J2B4vZWlz5fI5+Tg7McHP0ioCx0J
	yIzJjukbL3Gc4rpmZ3Q3O2YRgk/9xqiqcG7o9LCeJoYk6EPdxCmEKG06ttW+EjY59ZaByerSF6t
	XcFuQl0E20lrc48SdWyXtxTJjDOHuyCs6FT7rGWdeQTR+P9aL7nxS6yxgrqayZY/2FVZqoA=
X-Received: by 2002:a05:6a00:2d19:b0:845:d274:bf88 with SMTP id
 d2e1a72fcca58-8488974b08bmr8803485b3a.49.1783960276209; Mon, 13 Jul 2026
 09:31:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782745545.git.roxy520tt@gmail.com> <2e48ecffe7fa9e983203a22f68e603cd8530c5d1.1782745545.git.roxy520tt@gmail.com>
In-Reply-To: <2e48ecffe7fa9e983203a22f68e603cd8530c5d1.1782745545.git.roxy520tt@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 13 Jul 2026 12:31:04 -0400
X-Gm-Features: AUfX_mx1CDo7BZQmglawZqG1NRyl_wnyBCRDQIL0_HxGxENsvWC7vf1qcpO3oJc
Message-ID: <CADvbK_fCkj-WGok_yV8kGD9w-H=UWCG2TcRqSn5+wEhoAsTohw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] sctp: avoid auth_enable sysctl UAF during
 netns teardown
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, matttbe@kernel.org, yuantan098@gmail.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn, 
	tpluszz77@gmail.com, roxy520tt@gmail.com, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:matttbe@kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:tpluszz77@gmail.com,m:roxy520tt@gmail.com,m:sashiko-bot@kernel.org,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307248-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4749F74DA41

On Sat, Jul 11, 2026 at 12:22=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Zhiling Zou <roxy520tt@gmail.com>
>
> proc_sctp_do_auth() updates the SCTP control socket after changing
> net.sctp.auth_enable. The handler gets the per-net SCTP state from
> ctl->data, so an already opened sysctl file can still target a network
> namespace while that namespace is being torn down.
>
> SCTP previously registered its per-net sysctls from sctp_defaults_init(),
> while the control socket is created later from sctp_ctrlsock_init(). This
> exposed a window during initialization where auth_enable was writable
> before net->sctp.ctl_sock existed, and a teardown window where auth_enabl=
e
> stayed writable after inet_ctl_sock_destroy() had released the control
> socket.
>
> Move the per-net SCTP sysctl registration into sctp_ctrlsock_init() after
> sctp_ctl_sock_init() succeeds, and unregister the sysctl table before
> destroying the control socket in sctp_ctrlsock_exit(). If sysctl
> registration fails after the control socket was created, destroy the
> control socket in the same init path.
>
> Make sctp_sysctl_net_unregister() tolerate a missing header and clear the
> saved pointer so init-error and exit paths can safely share the unregiste=
r
> helper.
>
> Fixes: 15649fd5415e ("sctp: sysctl: auth_enable: avoid using current->nsp=
roxy")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Co-developed-by: Qi Tang <tpluszz77@gmail.com>
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/sctp/protocol.c | 17 ++++++++++-------
>  net/sctp/sysctl.c   |  9 +++++++--
>  2 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> index 587b0017a67d..f5fe6ddf0d7d 100644
> --- a/net/sctp/protocol.c
> +++ b/net/sctp/protocol.c
> @@ -1382,10 +1382,6 @@ static int __net_init sctp_defaults_init(struct ne=
t *net)
>         net->sctp.l3mdev_accept =3D 1;
>  #endif
>
> -       status =3D sctp_sysctl_net_register(net);
> -       if (status)
> -               goto err_sysctl_register;
> -
>         /* Allocate and initialise sctp mibs.  */
>         status =3D init_sctp_mibs(net);
>         if (status)
> @@ -1419,8 +1415,6 @@ static int __net_init sctp_defaults_init(struct net=
 *net)
>         cleanup_sctp_mibs(net);
>  #endif
>  err_init_mibs:
> -       sctp_sysctl_net_unregister(net);
> -err_sysctl_register:
>         return status;
>  }
>
> @@ -1435,7 +1429,6 @@ static void __net_exit sctp_defaults_exit(struct ne=
t *net)
>         net->sctp.proc_net_sctp =3D NULL;
>  #endif
>         cleanup_sctp_mibs(net);
> -       sctp_sysctl_net_unregister(net);
>  }
>
>  static struct pernet_operations sctp_defaults_ops =3D {
> @@ -1451,14 +1444,24 @@ static int __net_init sctp_ctrlsock_init(struct n=
et *net)
>         status =3D sctp_ctl_sock_init(net);
>         if (status)
>                 pr_err("Failed to initialize the SCTP control sock\n");
> +       else
> +               status =3D sctp_sysctl_net_register(net);
> +
> +       if (status && net->sctp.ctl_sock) {
> +               inet_ctl_sock_destroy(net->sctp.ctl_sock);
> +               net->sctp.ctl_sock =3D NULL;
> +       }
I think the Linux style here should be:

        /* Initialize the control inode/socket for handling OOTB packets.  =
*/
        status =3D sctp_ctl_sock_init(net);
        if (status) {
                pr_err("Failed to initialize the SCTP control sock\n");
                return status;
        }

        status =3D sctp_sysctl_net_register(net);
        if (status) {
                inet_ctl_sock_destroy(net->sctp.ctl_sock);
                net->sctp.ctl_sock =3D NULL;
        }

Thanks.

>
>         return status;
>  }
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

