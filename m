Return-Path: <netdev+bounces-294342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pR1MGaMjH2qLhwAAu9opvQ
	(envelope-from <netdev+bounces-294342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:40:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52878631297
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:40:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=e4+qoHGp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294342-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294342-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24A13300D756
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5074E395AF3;
	Tue,  2 Jun 2026 18:39:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AAE303A04
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 18:39:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425546; cv=pass; b=awkOaV6GVq9BZMd8YdzEY1M2Qqe9D1CIndh0tqteXaXNVetIIvmKjHMvpjbzBGUP5qIjO+n4dhsmQEWNLJ4qNtvd+zyiGBDsHtPAjkn9ticLqCqoQ7zzEAOgXoYmv1m4OqBjz+cOjDTM/fGU5FAB2Tc6i5zbnSvbMITiGD3Ofi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425546; c=relaxed/simple;
	bh=tJjN54GKlz2lAKlZqexmackAxnSmmvh+X9RO4pU7Afo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKr5u64P+tozPlcg+qQnrQFrFQOuYNg5ADysLKLO3aJP5MUJiqYe4cQR+tCFVAq/k/sQRq3ftK+avdU/lD4oEsI0NTdD8tdiBYPOzpor4V6F338tioCAsDWHLFiLq+cOtLPxNl55NlJPPwevvW+ZgY0FGKdLovJ+RrXFBOG5ZI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e4+qoHGp; arc=pass smtp.client-ip=74.125.82.41
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1363fe80fe8so14360386c88.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 11:39:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780425544; cv=none;
        d=google.com; s=arc-20240605;
        b=JXPAxJxeVIapmanqRdNALYADP+hTGOje2QwQtnEI2EVRXM3Z3gydePq7rvWmjj3bbA
         GENWdA2IK+jnr5DyUxSKuyNVp+Pl5qxAVrTm/ZRcsMkQdkY2KWMSDpmrnOnl1LEP5id6
         h+15BtK/ViIrCjHq2ZsxP45fi8M+v+SgzQJhvB8bj15wEYbhXOD7MygZtjNojBI/OAF5
         ZslG7NFQYToyUn4YoDVpek84QiW5zl1ZM5Gds0UxWn93UwxJJH65y7czt6/jCdhoUUPb
         jOdtHDQqvohGoTvi1vMRde4L1YxkUWCNvkgIcqH1pqhDWFQa8CO9ZAN+D3XEuua1udX3
         U0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=stXT9Bs2YIQYAv/LHnUQSreaDl+MmRo3wCjdy0GTnxs=;
        fh=YUMGnkU/PqqRpzqLzj6HqS6RakJuyoE3uUOqJ2h8sF4=;
        b=PPQvmupqh4X6LAvm5+BoCrfqCbF0SZZf+PVkiDhOa1ke4jVEaMjD4Sl1nsUrVT2zJQ
         Cxll4KCsQr3ds/1qepwz32RltcKejLH4+bypZgULwBe+TkDJbeIHC4uIRLvxlO/BUrJt
         ChiykH5AId64ban2pJENIcQ370ubQ/NjkTkvgS7Ilihi33yhsbQBTCQRPcfFxxfxxjKY
         2t4JsTmZmBSEFRse53Dekkh7AJ52ihqkhSmSBufp7l7PNg9NscVsQXlrTzbQqz2z1+cn
         OQfkUAu7m6qAe4FoVsw5Tad7UPdHq3Pns+pMXAw2aqNhOZo0/kgYg45KAAw013RXen/F
         NBqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780425544; x=1781030344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stXT9Bs2YIQYAv/LHnUQSreaDl+MmRo3wCjdy0GTnxs=;
        b=e4+qoHGp5Z7me+H3X4RO+n1rmZNI9+zfKiz8tg0P5/IXNDBKlctin91G4/3nFvbHUw
         7V6GS8HRB4I/1afyMYlfmhw/tVE6mKpcs6FmnPpbi+vaHR+m49Eg1lC0k3z6EFwDsVCH
         uwbtVOdzMzr2v0AGGnsmPCTZ3UJRROga5bJp72bFAbiwr22WeREDgAzMUpnZlRwAB+KE
         KxxBvFsjb9sdRIG1OgeHJW4mX2kNUFQzOLM4kXYGyB2he8xgwLjZllFChloqIKKwhAk2
         9EPTwu4U0cLayskbzMKEOfT009xt2Gh/gjj3q6HJ6jGNoMKtZY06EZmZtRfN9Pn27X60
         pPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780425544; x=1781030344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=stXT9Bs2YIQYAv/LHnUQSreaDl+MmRo3wCjdy0GTnxs=;
        b=T7jK5AezXY1N+IOTTSO+FxpmRlgf9NO+BskY0Rgik2NRR8+79Zzaj4S33JWpE2ySyq
         QYYmI+KorRCuCzmVOQGhO7QwBvMzhtv/IvTaLmfUsmLTC4Bp2XnKyhd6IJ1S78EC0gvB
         1DPkniV6iBJiRdZ2Xo04JfIyzBtUczr9mgwLEQBZnJWSWxkh6aMiyAGc/BcndYFEZpxW
         JgBRCeWU42CN0YNTISetKFg2CkyQNJ0gDVMMS5sPfE/5WS4wqUfbLZo73D5YCLNED4mF
         C1SJNkJCb89Fp0DE3wkPI4zoXodBizTY9ir9opBeilcrFYTbPCv3U7VMrahvmiXsDiVD
         O1AA==
X-Forwarded-Encrypted: i=1; AFNElJ8awejQH8zASaIo+6o0b1QxIqN3riEZ9CKZzC0UFm4Th0zhCzHU7mjTR02vW9psm7z+mHUXjBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+uSmgTTpXmN/FOA6q9APGfYdeEO7+X4ArfN7qA6CW8GLAvE3J
	vihhyAs6EwjcL5AojWG7aE3KMZ2gSDbw6/KYEkuJX169pDoGQU41Wuz6EdCyMCWdhzPKHA0dU6U
	0CywJkeohRGMlUWbDdVSE2PbTV8P0Wdd/fqsK/6/b
X-Gm-Gg: Acq92OHLo5AlnVqIDIWW5IvbZl1uqKBNK/pZ+atgOuzEIZ2TOkshF30uNvhpjIhfwsc
	cuY7aTOyfafH2V+HaiD++/LnKBly/NUD2gmq7fjYetR8Mk+Rynj9cWhMlRy8X7+z1O6xzKOwU85
	E+tz59+/LCjBXys7gmTCoQJhJfgRLj+yWZMtvt9oA9V9WcjP+4wIpCFuG3Vimod3iS1442qeXYg
	0rwAFh6LiES8VEiEzW8kp8or6hK+tbneZ/Gl9jQgry4shWF06fXNOihWONw8fXTnil4aEbeCYML
	Rg03lIjNxbYzzcKXKNKBEnAPkwUWWjNUkXIqNURzqzRB4JcemelKCqMjn2cZHhgtLwm4rqZ1mzd
	rS4VV5CD8mjMpcr360Gny8KuqyyGg3JEayJv4HmelOdbm/SZ30941HVVlJLOhHEc=
X-Received: by 2002:a05:7022:7a0:b0:132:956b:3c6 with SMTP id
 a92af1059eb24-137d424f2c8mr7374293c88.33.1780425543234; Tue, 02 Jun 2026
 11:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523061102.2762452-1-kuniyu@google.com>
In-Reply-To: <20260523061102.2762452-1-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 2 Jun 2026 11:38:51 -0700
X-Gm-Features: AVHnY4JxWE7ItoU3oB5RTJ3QMUWzINYBoYaDEp5HbL21X2M34bfgf_Nh18_p-u4
Message-ID: <CAAVpQUC5QL8_B3373b6461kAm7Kuj9AggED6fbXXE3-9usZHMg@mail.gmail.com>
Subject: Re: [PATCH v1 iproute2-next] iplink_geneve: Support IFLA_GENEVE_LOCAL
 and IFLA_GENEVE_LOCAL6.
To: Stephen Hemminger <stephen@networkplumber.org>, David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294342-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,saddr.family:url,daddr.family:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52878631297

On Fri, May 22, 2026 at 11:11=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6 allow specifying a local
> IPv4/IPv6 address for the backend UDP socket of a GENEVE devcie.
>
> Let's support the attributes with the "local" keyword.
>
>   # for i in $(seq 1 2);
>   do
>           ip link add geneve4_${i} type geneve local 192.168.0.${i} exter=
nal
>           ip addr add 192.168.0.${i}/24 dev geneve4_${i}
>           ip link set geneve4_${i} up
>
>           ip link add geneve6_${i} type geneve local 2001:9292::${i} exte=
rnal
>           ip addr add 2001:9292::${i}/64 dev geneve6_${i} nodad
>           ip link set geneve6_${i} up
>   done
>
>   # ip -d l | grep geneve
>   9: geneve4_1: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
>       geneve external id 0 local 192.168.0.1 ...
>   10: geneve6_1: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
>       geneve external id 0 local 2001:9292::1 ...
>   11: geneve4_2: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
>       geneve external id 0 local 192.168.0.2 ...
>   12: geneve6_2: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
>       geneve external id 0 local 2001:9292::2 ...
>
>   # ss -ua | grep geneve
>   UNCONN 0      0         192.168.0.2:geneve      0.0.0.0:*
>   UNCONN 0      0         192.168.0.1:geneve      0.0.0.0:*
>   UNCONN 0      0      [2001:9292::2]:geneve            *:*
>   UNCONN 0      0      [2001:9292::1]:geneve            *:*
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> The corresponding kernel patch will be posted separately.
> ---
>  include/uapi/linux/if_link.h |  2 ++
>  ip/iplink_geneve.c           | 43 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index a8c64be26f2c..d692d466da6b 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -1487,6 +1487,8 @@ enum {
>         IFLA_GENEVE_INNER_PROTO_INHERIT,
>         IFLA_GENEVE_PORT_RANGE,
>         IFLA_GENEVE_GRO_HINT,
> +       IFLA_GENEVE_LOCAL,
> +       IFLA_GENEVE_LOCAL6,
>         __IFLA_GENEVE_MAX
>  };
>  #define IFLA_GENEVE_MAX        (__IFLA_GENEVE_MAX - 1)
> diff --git a/ip/iplink_geneve.c b/ip/iplink_geneve.c
> index 62c61bce138b..8d21722b598c 100644
> --- a/ip/iplink_geneve.c
> +++ b/ip/iplink_geneve.c
> @@ -18,6 +18,7 @@ static void print_explain(FILE *f)
>         fprintf(f,
>                 "Usage: ... geneve id VNI\n"
>                 "               remote ADDR\n"
> +               "               [ local ADDR ]\n"
>                 "               [ ttl TTL ]\n"
>                 "               [ tos TOS ]\n"
>                 "               [ df DF ]\n"
> @@ -56,7 +57,7 @@ static void check_duparg(__u64 *attrs, int type, const =
char *key,
>  static int geneve_parse_opt(struct link_util *lu, int argc, char **argv,
>                           struct nlmsghdr *n)
>  {
> -       inet_prefix daddr;
> +       inet_prefix daddr, saddr;
>         __u32 vni =3D 0;
>         __u32 label =3D 0;
>         __u8 ttl =3D 0;
> @@ -72,6 +73,7 @@ static int geneve_parse_opt(struct link_util *lu, int a=
rgc, char **argv,
>         bool inner_proto_inherit =3D false;
>
>         inet_prefix_reset(&daddr);
> +       inet_prefix_reset(&saddr);
>
>         while (argc > 0) {
>                 if (!matches(*argv, "id") ||
> @@ -88,6 +90,13 @@ static int geneve_parse_opt(struct link_util *lu, int =
argc, char **argv,
>                         get_addr(&daddr, *argv, AF_UNSPEC);
>                         if (!is_addrtype_inet_not_multi(&daddr))
>                                 invarg("invalid remote address", *argv);
> +               } else if (!matches(*argv, "local")) {
> +                       NEXT_ARG();
> +                       check_duparg(&attrs, IFLA_GENEVE_LOCAL, "local",
> +                                    *argv);
> +                       get_addr(&saddr, *argv, AF_UNSPEC);
> +                       if (!is_addrtype_inet_not_multi(&saddr))
> +                               invarg("invalid local address", *argv);
>                 } else if (!matches(*argv, "ttl") ||
>                            !matches(*argv, "hoplimit")) {
>                         unsigned int uval;
> @@ -221,8 +230,17 @@ static int geneve_parse_opt(struct link_util *lu, in=
t argc, char **argv,
>         if (is_addrtype_inet(&daddr)) {
>                 int type =3D (daddr.family =3D=3D AF_INET) ? IFLA_GENEVE_=
REMOTE :
>                                                        IFLA_GENEVE_REMOTE=
6;
> +
>                 addattr_l(n, 1024, type, daddr.data, daddr.bytelen);
>         }
> +
> +       if (is_addrtype_inet(&saddr)) {
> +               int type =3D (saddr.family =3D=3D AF_INET) ? IFLA_GENEVE_=
LOCAL :
> +                                                      IFLA_GENEVE_LOCAL6=
;
> +
> +               addattr_l(n, 1024, type, saddr.data, saddr.bytelen);
> +       }
> +
>         if (!set_op || GENEVE_ATTRSET(attrs, IFLA_GENEVE_LABEL))
>                 addattr32(n, 1024, IFLA_GENEVE_LABEL, label);
>         if (!set_op || GENEVE_ATTRSET(attrs, IFLA_GENEVE_TTL))
> @@ -285,6 +303,29 @@ static void geneve_print_opt(struct link_util *lu, F=
ILE *f, struct rtattr *tb[])
>                 }
>         }
>
> +       if (tb[IFLA_GENEVE_LOCAL]) {
> +               __be32 addr =3D rta_getattr_u32(tb[IFLA_GENEVE_LOCAL]);
> +
> +               if (addr)

I'll remove this check to match the new dump behaviour.

pw-bot: cr


> +                       print_string(PRINT_ANY,
> +                                    "local",
> +                                    "local %s ",
> +                                    format_host(AF_INET, 4, &addr));
> +       } else if (tb[IFLA_GENEVE_LOCAL6]) {
> +               struct in6_addr addr;
> +
> +               memcpy(&addr, RTA_DATA(tb[IFLA_GENEVE_LOCAL6]), sizeof(st=
ruct in6_addr));
> +               if (!IN6_IS_ADDR_UNSPECIFIED(&addr)) {
> +                       if (!IN6_IS_ADDR_MULTICAST(&addr))
> +                               print_string(PRINT_ANY,
> +                                            "local6",
> +                                            "local %s ",
> +                                            format_host(AF_INET6,
> +                                                        sizeof(struct in=
6_addr),
> +                                                        &addr));
> +               }
> +       }
> +
>         if (tb[IFLA_GENEVE_TTL_INHERIT] &&
>             rta_getattr_u8(tb[IFLA_GENEVE_TTL_INHERIT])) {
>                 print_string(PRINT_FP, NULL, "ttl %s ", "inherit");
> --
> 2.54.0.746.g67dd491aae-goog
>

