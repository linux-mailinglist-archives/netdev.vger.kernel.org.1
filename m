Return-Path: <netdev+bounces-274930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIVHMpBxz2nAwQYAu9opvQ
	(envelope-from <netdev+bounces-274930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:51:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB7F391D6C
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 963F930381BA
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 07:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9466730B514;
	Fri,  3 Apr 2026 07:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFHRNrl4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B586A001
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775202665; cv=pass; b=kLxHrDIo9TOJ98NEGF6STPdoSCiI+Dpv38gkpgHrrYTDey6r4YiiJdcaBX1Iz8R9vo6B7NjKzZbNcBRSDDFniusp6q3FuRqHpfgSVwfwz7VO+4vDJ6X6gkpJmgrIo8XsENMQQ4ad6dkRSwpv5srdPagMBlx9L/D7pG6JY3Ef6EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775202665; c=relaxed/simple;
	bh=dd0wcVBzvcg1oc0Uq/WGTRb+kCuStk1ncnJUMitvdEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEpWTnjRDlwp6DxWw8WRS0Tr0FX9bZ/YfVCXFjslkjoehjZhNnSgaKRCuCQnA5DfhdBdO3U+W4O6JGhmv4jl4qEUMdhJpHyyqaZv51R8x9B6Nguh2dX9P9B00qsK/XnaVeuOSdmSgcgSZtN1n0ddpwbMugljwRUMquH/HFKPbug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFHRNrl4; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b886fc047d5so265212566b.3
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:51:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775202662; cv=none;
        d=google.com; s=arc-20240605;
        b=aqCtojQSbXpnB4m8ekxBxcGSZplJ7vz4RDMTsp4ky4hfuhLaZrHtvD3NDNmiJ3L8s/
         BV4RMbXujvQcNSqfytvAM1MB5Jei1fKLcfEsZUaHfTl6lKNlJ0CdlpcFVZNvM4r4W741
         /bZ0O3JNKsh5JHvSt3c2ut64u4OmykHwL9nkX1HTQ9YTB86JFWe8ZLKcExsOk8uTTyrh
         NcIjmoDGCjUwoC/rkVAcaNT7HPCrA1r27KdpNaFQ4QYvDl/K48m4lkEDFhvyZe27r8yp
         B3uAxsCbzllNoOqJO2+2R0yvY88BkFOJlaGFx8O82hBUaI/EQk5S/COExKEnENs1t3XS
         JxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NzoumJBKpZU/3O7s9r+rhYMdWgYGL90pbXwFIlwFZtw=;
        fh=fBcIi6LOBmWIqPjiHNi6OVFzFGukj7I6cPN145TL/GQ=;
        b=Czujy+m4MFiVENgKVqQArM28vF1Ne7jIIkap0ph1/qIo4iGUaCs9Rjdb3pafGXuGMI
         f3qB2A04+2ht6igEaMT5i51/qKIFc96Gx0du/RDIqxZWtBUQx5E4BmqR1KlA4u0o42UF
         YxKH1wYq2MMCDh0X4QcHHJmIdefHEY5Sp2t33BngTBeGI9vTGSoFaDm8ZICoFetpLE10
         zPEHddJY+w5Ia8z9zlqZ+NIBV28AelBMk0JzOpvHESDyXVYOBrJk3Y0W7JN/3gF+Rbrd
         Lux7aOCnPOL59dHANXqLAwtzhN4DpINJVNNLcH8EJU3Tt4nyZen/FeP3w9ZeVpnhmXYa
         z31A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775202662; x=1775807462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzoumJBKpZU/3O7s9r+rhYMdWgYGL90pbXwFIlwFZtw=;
        b=DFHRNrl4BPePVNp7vvg1hi9LbLQkMK/qSzBQK1/uSirS3eE+J5/F5UOS0tZj3dF7kn
         VCUYwJf2SHlZWwnXCTIsnTwyGMuqMxzgeM33VbKkzAFtgYaIdse26gnA+oFqhLdP/gRk
         0wsAv8itGxS3r6bTAi9/YxfFzrsW2IIf8bdSKv4dN9Qwk0FJE6Te7NK6GI4Tns36izpV
         MPWnxMj4XIT0MKN75o6X82TegMPtJND0TZBLQkH2d5y3ncQ2YqLMGR8qODueJCLrXU48
         9WejEc1lgVEcLiZCFGmENE1QrE0ufW8U3cmt6Ul086FpUOLifZ0qpR3r3qbTJOCm/7b0
         1qPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775202662; x=1775807462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NzoumJBKpZU/3O7s9r+rhYMdWgYGL90pbXwFIlwFZtw=;
        b=ASKQeP3Ni8vlDNCgwliQM1wXP1an6ws38NMDtUTrz8SefT1pwt3fXhosPCnHHw0vBw
         p70iHPnoSvdIZ54nw9O3U/GWQYZyacPlFfthSx7Vu6qRlDgVyFUJFANgHqxu2nU2heWD
         DCL/JZ7fFHlN6MpzM8k3FgIb+2bjT+UbaCgVsilwJIl5FIJguPdOfGK1jNybT/v2/iVx
         /LqdDquqPA/ynO+DhP2VJMmNgkhkZeCJKZa04PVy5ezcCl/1YZRrYqQnKRB/+Hh31EsE
         F0lZNq7neVAvZYY2eosrkPLU2aKsMaIL2DZiur81LqhIMm+rVnyqErqPNtiZgi/U5sPx
         qCtA==
X-Forwarded-Encrypted: i=1; AJvYcCVcK9hIYigfuasse6DVNtesdHTOCQlTgB1dlQHu4Lkefahg0WR9KM1tzZz+19mPgtT6nWFNQuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfh82JPCy9ee8DB9BY6ZmnDMKE9c5U5X5psQNwM8srqj7JAxWj
	gbyeEvzVJAYOXsUhyrZQSWf07ANTRCcj0t3y46OYafi0CZLi+lg/PoT+9n9ZE/DvbBzrBPzXXAG
	DiKaOt0jY0mZVUM47cHHWsfZAUQXlTrU=
X-Gm-Gg: ATEYQzxFtsWHK1PL8u7QV4508JGKEMuJauiz+hi0r7i1AJL4O8GIFvSy+W46zpNw0FY
	RZtZQIUCljJYi3l2pVEdgRGqLcRp26vYzTa3fbktT4e9xuv9SVcoHKl7rZ4pgm7Xmtvy+1eDboe
	mF7/meFvt/MMcifwlmcNgx1Q5S+wIrhP1Q7KNTYcgyK7XJeazFuRtaqzeKv065oehP8/g3Y++hT
	HJ2tQHjvZCvsOWF98osKWsdblwjK+c4w6SSeCG1PnQJNOH4gOCJ0Xniv++kmMfR2P1A1xZnpEGR
	UZp/zVmrnbTJb6+yXQ==
X-Received: by 2002:a17:906:478e:b0:b98:1129:51 with SMTP id
 a640c23a62f3a-b9c675492c5mr95779166b.17.1775202662236; Fri, 03 Apr 2026
 00:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
 <20260330191611.16929-1-royujjal@gmail.com> <20260330191611.16929-6-royujjal@gmail.com>
 <20260331141347.GA1637150@shredder>
In-Reply-To: <20260331141347.GA1637150@shredder>
From: Ujjal Roy <royujjal@gmail.com>
Date: Fri, 3 Apr 2026 13:20:49 +0530
X-Gm-Features: AQROBzCimHZIQikwfz6IXnJcfEgHNzZT7diUDVok-XKy8P3nRmO5_SZI4DRIkdI
Message-ID: <CAE2MWkn3gPc1kBwy2p7r5bx6QozMStM0N6oEutT7g7GnJrKteA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274930-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nvidia.com:email,bridge_vlan_mcast.sh:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5EB7F391D6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 7:44=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Mon, Mar 30, 2026 at 07:16:11PM +0000, Ujjal Roy wrote:
> > Add bridge selftests that configure IGMPv3 parameters and validate the
> > resulting Query packet fields for Max Resp Code (MRC) and Querier Query
> > Interval Code (QQIC).
> >
> > This also adds helper binary to encode floating-point exponential field=
s.
> >
> > Future extensions may cover corresponding IPv6 cases.
>
> Please cover both IGMPv3 and MLDv2 since the patchset touches both. You
> can add the MLDv2 tests in bridge_mld.sh.
>
> Also, I think you can simplify the test by simply matching on the
> expected values of MRC and QQIC using tc-u32.
>
> For both IGMPv3 and MLDv2 please test both:
>
> * MRC and QQIC in linear range.
> * MRC and QQIC in non-linear range.
>
> And please make sure the new test cases don't add new shellcheck
> warnings / errors or it will fail in the CI. You can ignore existing
> ones.

I will upgrade the existing test cases in file bridge_vlan_mcast.sh
instead of the previous file (bridge_igmp/mld.sh).

I have some doubts on test case logs reporting. Below are the logs
without my patchset. API used vlmc_query_intvl_test() and
vlmc_query_response_intvl_test().
TEST: Vlan mcast_query_interval global option default value         [ OK ]
TEST: Vlan 10 mcast_query_interval option changed to 200            [ OK ]
TEST: Vlan mcast_query_response_interval global option default value   [ OK=
 ]
TEST: Vlan 10 mcast_query_response_interval option changed to 200   [ OK ]

I am expecting some suggestions from the logs below. And are these
covers both IGMPv3 and MLDv2 for QQIC and MRC?
Actually mcast_query_interval=3DQQIC and
mcast_query_response_interval=3DMRC we already know.

TEST: Vlan mcast_query_interval global option default value         [ OK ]
TEST: Vlan 10 mcast_query_interval option changed to 200            [ OK ]
TEST: Vlan 10 mcast_query_interval number of IGMPv2 general query   [
OK ] -> old case added log
TEST: Vlan 10 mcast_query_interval option changed to 6000           [ OK ]
TEST: Vlan 10 mcast_query_interval in IGMPv3 is 60                  [ OK ]
TEST: Vlan 10 mcast_query_interval in MLDv2 is 60                   [ OK ]
TEST: Vlan 10 mcast_query_interval option changed to 16000          [ OK ]
TEST: Vlan 10 mcast_query_interval in IGMPv3 is 160                 [ OK ]
TEST: Vlan 10 mcast_query_interval in MLDv2 is 160                  [ OK ]
TEST: Vlan mcast_query_response_interval global option default value   [ OK=
 ]
TEST: Vlan 10 mcast_query_response_interval option changed to 600   [ OK ]
TEST: Vlan 10 mcast_query_response_interval in IGMPv3 is 60         [ OK ]
TEST: Vlan 10 mcast_query_response_interval option changed to 1600   [ OK ]
TEST: Vlan 10 mcast_query_response_interval in IGMPv3 is 160        [ OK ]
TEST: Vlan 10 mcast_query_response_interval option changed to 3000   [ OK ]
TEST: Vlan 10 mcast_query_response_interval in MLDv2 is 30000       [ OK ]
TEST: Vlan 10 mcast_query_response_interval option changed to 6000   [ OK ]
TEST: Vlan 10 mcast_query_response_interval in MLDv2 is 60000       [ OK ]

Or is it better to name them properly instead of mcast option names, like b=
elow?

Vlan 10 mcast_query_interval:
TEST: Number of tagged IGMPv2 general query                         [ OK ]
TEST: IGMPv3 QQIC linear value 60                                   [ OK ]
TEST: IGMPv3 QQIC non linear value 160                              [ OK ]
TEST: MLDv2 QQIC linear value 60                                    [ OK ]
TEST: MLDv2 QQIC non linear value 160                               [ OK ]

