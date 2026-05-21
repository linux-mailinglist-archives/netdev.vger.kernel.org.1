Return-Path: <netdev+bounces-290502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH5aLJovD2pSHgYAu9opvQ
	(envelope-from <netdev+bounces-290502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:15:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 246F75A90AB
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C095315A23E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C9C400E10;
	Thu, 21 May 2026 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJ5cE09K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C653EF67D
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374383; cv=pass; b=ec11k0WqN6b4VkUl3LxmqliKFRA3IuTGjrB6iJ7kO4HacuKTIcz174SFA4vO2GPd+7vpR+zvwvWFjr+IaWDgv89DQ+O4DwJLKqrPTUYT8VF7FN9u2kcj1H0hBDeJ0h6dKc5Ac03q5Qu6otPya/8zgzijU6Kb2Le5Zv1X2qv7BCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374383; c=relaxed/simple;
	bh=wYIb5rN3P7kuxixn1bdTEPgSLkphG9irWlDn2ffT/ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgNMTNM+xllHMAw3yVF6Np3oJ97N9J6SYgSl/TrxkP6vqrO/UH9Gp9yKAv5Gurk7c0kk8Qrj567JP8dJ1hmUpOcr3VR+rtRO+LkEEgWh01i8duo16gUVsa53dNktSvQdIltdSi8bWTGlMDSBGfBCQiT1P8BsEEJMdrFEPWrgNoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GJ5cE09K; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-516d0119e4aso2180971cf.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 07:39:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779374381; cv=none;
        d=google.com; s=arc-20240605;
        b=JdJX/XfXR6RklWQSrnoAovjLAlEHAdHkT6izjX8nh8jyjvxJmnLYBu5utWU+seKNQ1
         k8oxmjpVpFhCH8zn82/YRv15VRZ7ksr/Ho7Ik1gdR/+tRvA8FkGPk8C2+TbAoa6jWJJp
         cuH4eu+n/ZebVr6hTWalMDxySZTRY+gcQkAQC4LvullpSXy3BjnGzG6xGMwtUmTzc/l3
         lhwPPsalRLv+irmfFaknJcrRSd+oMpP5CiR/flfVRo3KbTG6KdPhP91nB/rvjPfIZgE0
         VZrjowbkYu0scDBWn8MSsr+lWCWxxPkXpXoAQIBAb57Gvim4vcToiH3bXKh4tOz1Aerh
         JpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=90Jz8cPF00cbR4Bu1muz3KoXvWhePQ5G+NSQ4v1nJsQ=;
        fh=zhAufyjR9v/9pJZEH01kcF5SZrXCVdSli6SZGlAqSbI=;
        b=jGJqCql4eWhBkk721AnV1V0spSUBdNPI1wxWvw+Znegtd8+Z9/nR37/R+vv4BEez+O
         2LvU+eBILYhjWOhMr7lhxAjYkbt6MgBPusiP8SoaGmeDsJbRdcgGoCjWyYN2PXWJn/Fy
         bG1p6J3VeoIK313x6HCAxkNF9mYoBLiKtNSg4vs1yOP5hxCCIJruomaUWTHblhvp4tYf
         EAA6CBIIbchaEej4bqm+0wUbaiX/c+jw/ujsAhhRl6aVn0xoLwURBICt3ng0OgGjYKoM
         smiZQ+ggxhaGEq47oJq+o7DlsKF8RnWbSl/6KUaoxQo6zmDwQ5exixVgy9RrvUX+3VgI
         mxhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779374381; x=1779979181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90Jz8cPF00cbR4Bu1muz3KoXvWhePQ5G+NSQ4v1nJsQ=;
        b=GJ5cE09K6cXagIWh/w+UWDRKcBGYRtskI3rjGgPT5w3/wXAlbanRK2gpEbPXKKJuAS
         TXZxyls+51YlslGEAwRsmGkCADCTIpCjxepHe6a6fcny0VeNZajpTtLexw7qzDUKGcMA
         fMf67lTmZq/7Gz7xnRXZk+ynA8z8U6esAr1lwPte4RvZ1ZTrO1zpaSX9TFgf7VLCFJme
         TAl3ua9DuhakG9GNVmKE1tc+mJrn+JvC+p3PIopto8LJQTX8pMiKdoctXc7TukNF4525
         09i7y4odgTQBfrEtCQzBsY3jDuO4NWhvnZ491jWFJaLsz/fx/IOIVqIgkaTUY/pffcpk
         6neA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779374381; x=1779979181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=90Jz8cPF00cbR4Bu1muz3KoXvWhePQ5G+NSQ4v1nJsQ=;
        b=FJ/9Yebmtu5YvRd2ZxdpOxFTfWvMJewc4u2icxNyxY8pg66FedlipZVQYw8HcL6gW7
         WUfuXaAopFNrzhgI+uvS0ioJdOQrrJNzAQZb9Nx27iHfdK9XIBnPUOe1xLLTYhYnUhk/
         TwpbLqthY9/n+7saOqauFf6BNv8SqAqz5ZOvfa1HyHxyNFEY8U4fZUbPt8mNjb7miHJ5
         kwpqZGemhz0fQq1hnXa/+D/c0JbZV4bjlF5mmCKam8xzHurJLo7lYxI4/jfTBmpTA6XA
         QAIXKhSNzN4+GJSMV7c0MhUq9LFPQ4H04CeO987SuAku0GlE4EnOA1E66HYHXILwsQZ6
         kxMw==
X-Forwarded-Encrypted: i=1; AFNElJ/4UaUNdn6n4m2g+DpAgLgkYZ+LnF+k6dCJ4+TxmxXRVNHCxy0irItszhdIozRV3YBmSdpbfm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFKW8+x5gv5G6cXOYi87/NWts0X5v+oBG4SmsBGPcPmFsGHf2F
	ifvdjq0z+gmXUo1FBFf1qaxZLzyE2JJMbIeYLewVKhuVRdOxIYhUkO6HglwRBSV9ZASIprvIEaR
	dxrNtEEs8j0FKJMIskXeUkf7bbAI5KoN92FLbdMxz
X-Gm-Gg: Acq92OElMW7BGN0N1t56J4KXFK/gs1xzGc22qtcpoS/5FYZq4HERbSU6C7yc7I2pUdu
	YNLzKqqM/1SigfA2OgWRSIwyruPQQjOTPD5o/w+6jrd+cBJeE/1eQ4g6576mpRRmCx1O14Rr4zn
	5YGOS/7QzUj3e3SJYVK19xg1rJavdlsgVpDiXjyqaTvkgNDKamlwtNRmSTgP+KsGZg9pmobLa7N
	lthbsjb8zQgiQuFrvoT6Dak11eGvZj+lSfw5K4AwOClWKGzopXtjnKDmrLfHAQVntRlgNlF3BRl
	/ItsKBFSl1nnIKvxznpZXpx0z3e8WCE1fufFy1fnImiNyZLdhn/WHS/ttN9jAzkGz5b2B9IGEz9
	fxbz5dNWn+71/aDCQXvXPQKhMdZxwl8Y8FwhkbTq1xnbgB5CHwxgUcy1q6Eu4HSK0
X-Received: by 2002:a05:622a:1920:b0:516:6749:4036 with SMTP id
 d75a77b69052e-516c55d2c6amr35337451cf.22.1779374379762; Thu, 21 May 2026
 07:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521122147.3584624-1-edumazet@google.com> <0ef1f7da-c5b3-4c91-a656-4a3efecbbaf2@linux.dev>
In-Reply-To: <0ef1f7da-c5b3-4c91-a656-4a3efecbbaf2@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 May 2026 07:39:28 -0700
X-Gm-Features: AVHnY4Krb7ufidsKA2p2_kj9pW905P0xfy5WN5RnvG6O3wSXEklr0RrIrlQT1vs
Message-ID: <CANn89iKtnq+-d7EVYjJa1vLRGVA14hi6d4KWkas86W9K10tdcA@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: free net->ipv4.sysctl_local_reserved_ports
 after unregister_net_sysctl_table()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	"Ji'an Zhou" <eilaimemedsnaimel@gmail.com>, Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,nvidia.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-290502-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: 246F75A90AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 6:59=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 5/21/26 8:21 PM, Eric Dumazet wrote:
> > ipv4_sysctl_exit_net() is currently freeing net->ipv4.sysctl_local_rese=
rved_ports
> > too soon.
> >
> > Only after unregister_net_sysctl_table() we can be sure no threads can =
possibly
> > use the sysctls, including /proc/sys/net/ipv4/ip_local_reserved_ports.
> >
> > Fixes: 122ff243f5f1 ("ipv4: make ip_local_reserved_ports per netns")
> > Reported-by: Ji'an Zhou <eilaimemedsnaimel@gmail.com>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Cong Wang <xiyou.wangcong@gmail.com>
> > ---
> >   net/ipv4/sysctl_net_ipv4.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> > index d8bdb1bdbff17ab52fe969b93ce13673e88c05a4..c0e85cc171aec099fd5d489=
7b1a623dd27eaee08 100644
> > --- a/net/ipv4/sysctl_net_ipv4.c
> > +++ b/net/ipv4/sysctl_net_ipv4.c
> > @@ -1705,10 +1705,10 @@ static __net_exit void ipv4_sysctl_exit_net(str=
uct net *net)
> >   {
> >       const struct ctl_table *table;
> >
> > -     kfree(net->ipv4.sysctl_local_reserved_ports);
> >       table =3D net->ipv4.ipv4_hdr->ctl_table_arg;
> >       unregister_net_sysctl_table(net->ipv4.ipv4_hdr);
> >       kfree(table);
> > +     kfree(net->ipv4.sysctl_local_reserved_ports);
> >   }
> >
> >   static __net_initdata struct pernet_operations ipv4_sysctl_ops =3D {
>
>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>
>
> If there are still processes in the namespace, the netns refcnt cannot
> become 0,
>
> so I think it should be: first open
> /proc/sys/net/ipv4/ip_local_reserved_ports, then pass
>
> the fd to another process outside the netns? Maybe SCM_RIGHTS is used?

We will not share the repro publicly, for obvious reasons :)

