Return-Path: <netdev+bounces-274983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Jt1MHuXz2nmxQYAu9opvQ
	(envelope-from <netdev+bounces-274983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 12:33:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BE739352A
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 12:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 758E0302F573
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 10:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481F33AC0D7;
	Fri,  3 Apr 2026 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDxRykA/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833EE3ACA68
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775212285; cv=pass; b=StALVzob9k7uLl3GOGAQBFZNV+xm2fTK0N+8rI3h8Jk05l6NiC9jG8qsjc5gNgxWcyHtGIntCcwzM1ej4/UFAGadzRocMm8AspKM23JjvcsH4Ek+fMTas2UMEralo9b5PBPgHXn8OVNoblP9Rxoj4PoeUncZApTxJ9H/D7Nohc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775212285; c=relaxed/simple;
	bh=aovUneDvP1GBNolJAjVlVkkQADn5zmmkErYFqtVNwNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiZliLqCQqxewvrGyA83ruwO4L1vzagmj5RwdjiOaWIoe+6wFD6OeDDqFEaH6E10K8a7K+2mI+ZilLdAA07zaUKr5/zlkQ393Ki5KpQF0EPCMjWkNZQuAg8DIRK3n+grDXp7UVNJ1pW1++PlD+7swyMSPVwuXjFjvowJrBZJgdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDxRykA/; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9c1da7ac63so312652966b.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 03:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775212281; cv=none;
        d=google.com; s=arc-20240605;
        b=Mom/0P/mmzAmeJe0GykC1Hbw8QJZ81gEnQZdH6685NbnSsAjsxfa+PTJELa9kSH7MC
         RWarjpKxzcmk7Ne60/ZJjT/O4wzCLu66aZsfn5dqqJaFviE24EmfTjuDO8mVGaveJuU6
         WmwFWEh1AYfWLt0wUYK7onzGQJWLjOEmjYlLSIpshf629hRLGwc7vNt61lUR9VggralY
         cfXEBNN6f8z7OmVHig4/wnUAZESI7EFqDlEyE5Kfg/oT0df1G78TDL5LUTNYTzLnDmkd
         9H5eABloRGA70ftmgPt7nl4uNlj+vxV02tkiLlZQVNVXVWsOp8UpynuuytqvBE5/7F5c
         0LQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QHwL4zXImEU/IfCJ7oBNFaaImV63q09hkn+e/UcNPOA=;
        fh=uyjyuyxNZHi+5eIMUnl+/wEqrYSp0nAEdGHcQG7ZJPk=;
        b=EnU/tbpURNdMlY9XIf4inV4CTo7qzJnwPwm19RnrOcG2LkHGHRsEwPpDR4ZqXQX0zQ
         ZsdDAo00xKgeir/E4AQc3BWZXHvgqpe6qZHK7ecLUp2ybnT0uk5VBktVAx0aBeUpDg6V
         CUGh2coq/0fZ7CYkrLhg7pDpUs/NOj/02+gWqeBJybM/y7BOsIXlHc3F9TdNLRGFoege
         H3bzFw8CqGMLQQTARgrzNvSLiunQf7geL4reI03Mjkppf8mD8HNb4qCK2R2TjiOWIePQ
         IlfZR9G2y1Q+4/UbQkFt1LAJOYb76bLjQvnGlqHYAoUoboi0bxa6AkAoQJvo2Buh0910
         nfBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775212281; x=1775817081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHwL4zXImEU/IfCJ7oBNFaaImV63q09hkn+e/UcNPOA=;
        b=ZDxRykA/ceBc+Lg1qnQgY6Rjyz1ySfH/Ga9M8oDV5SBy2WtAYOAPsg8RxOREOIREV0
         A6xbJXwbthrs/FEh6cOIZJtkt4MbrF/US9MEk+6MAWDPv9vHGPDXI18jVfZm6a8igHJ0
         wQGMeonmROvJrxFDdaLssBPpRrKAx31tLxDZestO6jWSaFB5SYolrC+pXBSpzF8OV+K+
         VJhD8s6LhaxBAOteerG+BOcQfCU+kjIZm8hiNE54xSRVPxJgqNqxFt8KaVJr4INZIYhl
         QF+s2M0TrGl17+bjXd4vzndGBSJSUqKIz/Py/9qJQtfSHtyS72b1LesY3kCqYZKr0Omm
         VBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775212281; x=1775817081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QHwL4zXImEU/IfCJ7oBNFaaImV63q09hkn+e/UcNPOA=;
        b=XAMl9Ps6S6fqXN2w50v6qIV1xgocF80RDx6EajXWNlSMeiseIhcURUs/HX+RhDknSa
         GNCvU3NpuRpMW4Ju6/G1hbdmA0lNWCeqyaI/eCBqKbhvhN4TCKr1rNMHI4S/+0tf8/Ne
         aem4Jx+2At9t3oc/ExtgoK+6AsNMl7CFmweS5/A0s8aOU9gdtuzaJ8R8aNjkktAf4Byi
         nvyP3YEDf/fDLoxbxerO8O8Z9HbZsOZTVsiCKWh1J2WZkQAEetukfrv2+3GH3UmE/wls
         kYx3T0ShxMGk4z/XqQSzIkoQ9Jdlfey3j/Tvu+Zvaq6PUOfWYLyVkMZqkMOj5QId8K8Z
         MRag==
X-Forwarded-Encrypted: i=1; AJvYcCUs/QLdVWHZ6PF1RNGHu5kiO43Hjpy34nlhFFELg5wROEln6Kqc3L/AFkAR5Rz6gk8JHcT1JVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/KvJI2hPJPGpQH3IOB5KGDZ83GMuKzMM+/PhDbFzOJsXFia/L
	r+Hp53wBHcWwI7SHnsRXnF+nbTJuj2erQbi10WYgkhUQvuhxWqbUJhaUhobRXqkB4Ja6Q1sdvDd
	a8hujapEcZYwQ86AwhAk8rXl01B8AXXM=
X-Gm-Gg: AeBDieuPivJohZa3bp0/NkhP6BzQy1WWWnyxw2NrP1Qg9PD/c1B96GViKILbD2SbIzI
	SSSC8U6t0LgPYm0bNswUOYGJAQvGN5Jxz4Txi30fldT2cX7d1vHyoJFptH1uzfgsp2JWm2EDbAj
	pmKa+gkvYgpPxMIcL2aNfmlBm7ybsxTkclG2FbHNjUNriM21tk8mwXxoXZBBj/nCjRU1qZsIO4L
	wAlBKEbN42TLfqKhtgcftzXDU0Z2zhdyk4FbJcAsRBDvZk/RhG3G9XOTgmt0LcvaA0q1ad8TDDb
	Gy0Zvxs=
X-Received: by 2002:a17:907:d005:b0:b9c:393b:f6a4 with SMTP id
 a640c23a62f3a-b9c679adcd8mr122872766b.28.1775212281230; Fri, 03 Apr 2026
 03:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
 <20260330191611.16929-1-royujjal@gmail.com> <20260330191611.16929-6-royujjal@gmail.com>
 <20260331141347.GA1637150@shredder> <CAE2MWkn3gPc1kBwy2p7r5bx6QozMStM0N6oEutT7g7GnJrKteA@mail.gmail.com>
 <20260403101944.GA66518@shredder>
In-Reply-To: <20260403101944.GA66518@shredder>
From: Ujjal Roy <royujjal@gmail.com>
Date: Fri, 3 Apr 2026 16:01:05 +0530
X-Gm-Features: AQROBzBqpVc7_CAPXcQpzbI6yBbYR-8a-svH1NtOipIeuqjLRiO89y7FSqh-KG4
Message-ID: <CAE2MWkk0_B78wEnt+NwrCZ0653W_BHxNWjT+7F70KWHtmiugKQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/5] selftests: net: bridge: add tests for
 igmpv3 MRC and QQIC validation
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274983-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,bridge_vlan_mcast.sh:url]
X-Rspamd-Queue-Id: 67BE739352A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 3:49=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
[...]
>
> Is there a reason to place them in bridge_vlan_mcast.sh given they are
> not specific to the per-VLAN multicast context? bridge_{igmp,mld}.sh
> looks like a better fit.

I could see the framework is ready to validate using
bridge_vlan_mcast.sh script. Just had to apply a new tc rule to
validate QEURY+MRC/QQIC fields. Something like this.

                tc filter add dev $dev egress pref 10 prot 802.1Q \
                        flower vlan_id 10 vlan_ethtype ipv4 dst_ip
224.0.0.1 ip_proto 2 \
+                       action continue
+               # AND Type 0x11 (Query) at offset 24 after IP
+               # IP (20 byte IP + 4 bytes Option)
+               tc filter add dev $dev egress pref 20 prot 802.1Q u32 \
+                       match u8 0x11 0xff at 24 $intvl_match \
                        action pass

And writing a few lines will validate the test for IGMPv3 QQIC non
linear value of 160s.
+       RET=3D0
+       bridge vlan global set vid 10 dev br0 mcast_snooping 1
mcast_query_interval 16000
+       check_err $? "Could not set mcast_query_interval in vlan 10"
+       log_test "Vlan 10 mcast_query_interval option changed to 16000"
+       # 1 is sent immediately, IGMPv3 QQIC should match with non
linear value 160s
+       vlmc_check_query igmp 3 $swp1 1 1 160
+       check_err $? "Wrong QQIC in sent tagged IGMPv3 general queries"
+       log_test "Vlan 10 mcast_query_interval in IGMPv3 is 160"

>
[...]
> > Vlan 10 mcast_query_interval:
> > TEST: Number of tagged IGMPv2 general query                         [ O=
K ]
> > TEST: IGMPv3 QQIC linear value 60                                   [ O=
K ]
> > TEST: IGMPv3 QQIC non linear value 160                              [ O=
K ]
> > TEST: MLDv2 QQIC linear value 60                                    [ O=
K ]
> > TEST: MLDv2 QQIC non linear value 160                               [ O=
K ]
>
> I find the latter clearer.

I thought so, hence asked which would be a better version of log.
Thanks for clearing it.

