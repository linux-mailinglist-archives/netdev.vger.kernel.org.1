Return-Path: <netdev+bounces-14513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B89B742356
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 11:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F69C280D30
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 09:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B751FA95F;
	Thu, 29 Jun 2023 09:36:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC101A92D
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 09:36:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF62ED
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 02:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688031405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kYG1165Me8KXJ6bBjdSoZbHbdY4Mqr1aH4o7+E05ySg=;
	b=T/AtyCbSSyKZvMdySiBMy+Kb2T7J5mAwjeC9sjtacVSlzrxbRxCTzp3+y4NAtg7xAJEZ7X
	7jVedLeNqPR7+CWrCLAefKCVB/kAeu8BBIVtcYU+9LaPFLi883mqDZgD9zqNDIe7nZUqYz
	NgpHy8Sjf/rM8LPIwjiqTkVRAcarsoU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-P64FJrbrMw-uKDl79EtXlg-1; Thu, 29 Jun 2023 05:36:44 -0400
X-MC-Unique: P64FJrbrMw-uKDl79EtXlg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635eb5b04e1so1257216d6.1
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 02:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688031403; x=1690623403;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYG1165Me8KXJ6bBjdSoZbHbdY4Mqr1aH4o7+E05ySg=;
        b=XNVktcu3cYwjyIIHWpzI6SpzXDDWGTOCMtD6jJa3W4tvupP+feTNDQErKNeThkPYkw
         nwKwXF/z8UqJ1H2H84LFlUYaXi6o226wgTJKzSfBTw8qNUjH5YkDEUC6ZO4SwK191vXL
         XjWCBa5/UJ1uEq9NYSjUgvU5DYLthf5u7YbA/ZxGvDIl+OPoyuq3onrNtEQ8y0GqQ+2v
         JIIBzoB7xebTHy3naa42bofThvjeZ4bEAVpni+1TFA4ZCmQT/VFjtWWSVhN7rVMgikAH
         IZY/ZJOSKbI7/Eyhb6oZb4LaW0qhA4S+Yc4RjhQ6Kbz08EAbmRq04ndFUU31dIOD2CD+
         Zgbg==
X-Gm-Message-State: AC+VfDy4Hg2X0PVmmOijKevPgmBAOlfuCNCjtjfy9AOYInILQKCjx5rC
	MIUL34Ls1d6FmrDEAx01staqAXs4BBjphE5QlzpDXDV/d7O1jbAjxsOI7D0JKpyfjfn8aMRMCN1
	boPVTup+nM0OWNhtQ
X-Received: by 2002:a05:6214:2685:b0:635:d9d0:cccf with SMTP id gm5-20020a056214268500b00635d9d0cccfmr15599002qvb.4.1688031403302;
        Thu, 29 Jun 2023 02:36:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4BmkCKu61s65/tlTA6LaHGRA7CUgp6qEKNNQ7/tTCVQYIODra+A0gDSS6lCTkjsGr5mKXp1Q==
X-Received: by 2002:a05:6214:2685:b0:635:d9d0:cccf with SMTP id gm5-20020a056214268500b00635d9d0cccfmr15598986qvb.4.1688031403003;
        Thu, 29 Jun 2023 02:36:43 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-196.dyn.eolo.it. [146.241.231.196])
        by smtp.gmail.com with ESMTPSA id j5-20020a056214032500b00636056961c6sm1532031qvu.75.2023.06.29.02.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 02:36:42 -0700 (PDT)
Message-ID: <f494387c8d55d9b1d5a3e88beedeeb448f2e6cc3.camel@redhat.com>
Subject: Re: [PATCH v2 net 1/2] net: dsa: sja1105: always enable the
 INCL_SRCPT option
From: Paolo Abeni <pabeni@redhat.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 linux-kernel@vger.kernel.org
Date: Thu, 29 Jun 2023 11:36:38 +0200
In-Reply-To: <20230627094207.3385231-2-vladimir.oltean@nxp.com>
References: <20230627094207.3385231-1-vladimir.oltean@nxp.com>
	 <20230627094207.3385231-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-06-27 at 12:42 +0300, Vladimir Oltean wrote:
> Link-local traffic on bridged SJA1105 ports is sometimes tagged by the
> hardware with source port information (when the port is under a VLAN
> aware bridge).
>=20
> The tag_8021q source port identification has become more loose
> ("imprecise") and will report a plausible rather than exact bridge port,
> when under a bridge (be it VLAN-aware or VLAN-unaware). But link-local
> traffic always needs to know the precise source port.
>=20
> Modify the driver logic (and therefore: the tagging protocol itself) to
> always include the source port information with link-local packets,
> regardless of whether the port is standalone, under a VLAN-aware or
> VLAN-unaware bridge. This makes it possible for the tagging driver to
> give priority to that information over the tag_8021q VLAN header.
>=20
> The big drawback with INCL_SRCPT is that it makes it impossible to
> distinguish between an original MAC DA of 01:80:C2:XX:YY:ZZ and
> 01:80:C2:AA:BB:ZZ, because the tagger just patches MAC DA bytes 3 and 4
> with zeroes. Only if PTP RX timestamping is enabled, the switch will
> generate a META follow-up frame containing the RX timestamp and the
> original bytes 3 and 4 of the MAC DA. Those will be used to patch up the
> original packet. Nonetheless, in the absence of PTP RX timestamping, we
> have to live with this limitation, since it is more important to have
> the more precise source port information for link-local traffic.

What if 2 different DSA are under the same linux bridge, so that the
host has to forward in S/W the received frames? (and DA is incomplete)

It looks like that such frames will never reach the relevant
destination?

Is such setup possible/relevant?

Thanks,

Paolo


