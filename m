Return-Path: <netdev+bounces-59932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9A281CB1E
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 15:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B2C284E54
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 14:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16271A5A3;
	Fri, 22 Dec 2023 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UK5vkZxB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F51A733
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-427a22138f5so7284721cf.1
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 06:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703254164; x=1703858964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BdAgG6i9jIB2TYCqiVaEW7vZuO3KvYTlGf6En/hSVGk=;
        b=UK5vkZxBe7SQESHEDPJnjsg6E8ZEhSLCLQTBdKmVbQXynmuM5Rh/KL/CKPRckejASt
         FLGel3l3XC2X9pAFyxeffzgaoHjCMcr3I7WCIRqtRhReVF9wUOfDpMYB9v1NMsXqlcNM
         kRevELnXrSvapEuu0OioT/GIisaiwHcMe7kBTqX8Ayt2zaLTYx2+OPJB/a9Xe0xsUHCS
         lkk2mgSJVcXPv19CylwppNd1hbArJY+DFVQEcp+70DnY79VC78KC0JjpAH+3cLf9N17p
         z3wkYqjXMFq2LNrwqne1j6iv42u8N9oWqzw7IHGWzWS9+/w4Wm+EcSa4AVKZdsmu39mI
         K0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703254164; x=1703858964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdAgG6i9jIB2TYCqiVaEW7vZuO3KvYTlGf6En/hSVGk=;
        b=iEkIP0avUHmVjZX3dqNTN44sy3EZCPaV+PAcnpDDgmCFi7/TLzEhg7M6+q4ZDbN4ZT
         43GXNauk0d7ZoWgSTUF8IpA3VlnT0j4/bUwnIsysBfkHUWQZa8CHanfAZfJhxdXbTr2D
         02Z0SijhGEapaKZzTqZctpMzChYWSurICUs5ub0nOG9oOY/0b2FXy+rzjW9eQNcM8wou
         PgELjiIcovLTlahax2OSa1+uhvS3sIzBaooKaWlsTtb0iIeiUcDf9qAC0yAb7Ohqu/ca
         2t2AIY70/NsNLfopZOg6hkp4kmyCoCMcEGRdDFG9U1b0ek2+sA5woNGP3FxSJnMVc48B
         2Z7A==
X-Gm-Message-State: AOJu0YyA+7rtxXVhdzouKjEfgUbt4mbT8nuK9lS65bJeY3zSZsZy/kQQ
	ejZd4dpX++P16k5EuRgIws0=
X-Google-Smtp-Source: AGHT+IH/0fQZ5kz7clOa8Cvc0kAZ9KUjduJ7UeQBlI6gc/6piO/Gpq43/IBTz41wM8eM77CMzkBHTQ==
X-Received: by 2002:a05:622a:44f:b0:427:7da3:13de with SMTP id o15-20020a05622a044f00b004277da313demr1403303qtx.96.1703254164276;
        Fri, 22 Dec 2023 06:09:24 -0800 (PST)
Received: from localhost ([69.156.66.74])
        by smtp.gmail.com with ESMTPSA id eo12-20020a05622a544c00b00427692bc384sm1841133qtb.66.2023.12.22.06.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 06:09:23 -0800 (PST)
Date: Fri, 22 Dec 2023 09:09:15 -0500
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>,
	Patrice Duroux <patrice.duroux@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	mlxsw@nvidia.com, Jay Vosburgh <j.vosburgh@gmail.com>
Subject: Re: [PATCH net-next] selftests: forwarding: Import top-level lib.sh
 through $lib_dir
Message-ID: <ZYWYi8bfns6ohtKD@d3>
References: <a1c56680a5041ae337a6a44a7091bd8f781c1970.1702295081.git.petrm@nvidia.com>
 <ZXcERjbKl2JFClEz@Laptop-X1>
 <87fs07mi0w.fsf@nvidia.com>
 <ZXi_veDs_NMDsFrD@d3>
 <ZXlIew7PbTglpUmV@Laptop-X1>
 <ZXok5cRZDKdjX1nj@d3>
 <ZXqpieBoynMk0U-Z@Laptop-X1>
 <ZXt6_4WCxYoxgWqL@d3>
 <20231221165820.kmycryea2wse7tol@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221165820.kmycryea2wse7tol@skbuf>

On 2023-12-21 18:58 +0200, Vladimir Oltean wrote:
> On Thu, Dec 14, 2023 at 05:00:31PM -0500, Benjamin Poirier wrote:
> > Patrice, Vladimir, Martin, how do you run the dsa tests?
> 
> Not how they're supposed to, apparently.
> 
> I used to rsync the "selftests" folder to the device under test, go
> to the drivers/net/dsa directory, and ./ the test from there. That is
> absolutely sufficient without all the "make kselftest" / run_kselftest.sh
> overhead which I don't need, but apparently that broken now too.
> 
> I don't have a strong objection against eliminating the symlinks.
> They were just a handy way of filtering those tests from net/forwarding/
> which were relevant to DSA, and just ignore the test.
> 
> What might turn out to be problematic is DSA's forwarding.config, where
> we actually rely on the STABLE_MAC_ADDRS option for some tests to pass.
> I'm not actually sure what is the "recommended" way of deploying a
> custom forwarding.config file anyway.

Thank you for sharing that info. There are so many different ways to run
the selftests, there is no "one true way". Thanks to Hangbin's
suggestion earlier in the thread I found a way to make things work for
the dsa tests after commit 25ae948b4478 ("selftests/net: add lib.sh") by
adding a wrapper script that sources another test; see the RFC that I
just posted:
https://lore.kernel.org/netdev/20231222135836.992841-1-bpoirier@nvidia.com/T/#t

drivers/net/dsa will still have links to the net/forwarding/ tests so
today's functionality should be preserved, including forwarding.config.

