Return-Path: <netdev+bounces-54028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC5C805AAD
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 18:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDFD21C20F54
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA3F69286;
	Tue,  5 Dec 2023 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=piedallu.me header.i=@piedallu.me header.b="AVQE/6Lk"
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 11124 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 09:05:45 PST
Received: from 3.mo580.mail-out.ovh.net (3.mo580.mail-out.ovh.net [178.33.255.153])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F3383
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 09:05:45 -0800 (PST)
Received: from mxplan8.mail.ovh.net (unknown [10.109.146.96])
	by mo580.mail-out.ovh.net (Postfix) with ESMTPS id 597382435D;
	Tue,  5 Dec 2023 14:00:19 +0000 (UTC)
Received: from piedallu.me (37.59.142.107) by mxplan8.mail.ovh.net
 (172.16.2.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Dec
 2023 15:00:18 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-107S001432695c8-33c5-4fb7-8a7c-d9542a815873,
                    74C7C1992E4F488363DD529DEE5BA00C4ED99BDC) smtp.auth=postmaster@piedallu.me
X-OVh-ClientIp: 176.169.226.152
Received: from salamandar.fr.lan (unknown [45.81.62.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by piedallu.me (Postfix) with ESMTPSA id 1E2D06004D;
	Tue,  5 Dec 2023 11:20:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=piedallu.me;
	s=mailkey; t=1701771640;
	bh=36C+DjkFIsZAsYt7V6sqOaJ1IjI6J30mM0cjv7+1rp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AVQE/6Lk6PxoJp0M8anlRYtH5KL8G4nGt2f2ZRWwMVWelpNc/e3miIK30qRW2KEzP
	 Fj2UVI33nmAbgBjUa4THc9dKo86FKXftxKGZp3p+vGGLGWA4ts3UQMk0wX1R++i4yj
	 UKHjfPsj03oDLFVTYbBgC92XG5alQIXAvsMOxqko=
From: =?UTF-8?q?F=C3=A9lix=20Pi=C3=A9dallu?= <felix@piedallu.me>
To: andrew@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ramon.nordin.rodriguez@ferroamp.se
Subject:
Date: Tue,  5 Dec 2023 11:20:39 +0100
Message-ID: <20231205102039.2917039-1-felix@piedallu.me>
In-Reply-To: <f25ed798-e116-4f6f-ad3c-5060c7d540d0@lunn.ch>
References: <f25ed798-e116-4f6f-ad3c-5060c7d540d0@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-GUID: d137995d-c8aa-4c45-9d08-67be1aa9503b
X-Ovh-Tracer-Id: 3238932558428276914
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 10
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudejkedgheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucfgmhhpthihuchsuhgsjhgvtghtucdluddtmdenucfjughrpefhvfevufffkfgjfhggtgfgsehtkeertddttdejnecuhfhrohhmpefhrohlihigucfrihoruggrlhhluhcuoehfvghlihigsehpihgvuggrlhhluhdrmhgvqeenucggtffrrghtthgvrhhnpeffteegleduieefleeigeeuueettdelteegheehvdeuleekveduteegkeekgeevvdenucffohhmrghinhepmhhitghrohgthhhiphdrtghomhenucfkpheptddrtddrtddrtddpudejiedrudeiledrvddviedrudehvddpgeehrdekuddriedvrddujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghnkedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehfvghlihigsehpihgvuggrlhhluhdrmhgvpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedt

Subject: Re: [PATCH 2/3] net: microchip_t1s: add support for LAN867x Rev.C1

Hi, 

> So there is a gap in the revisions. Maybe a B2 exists?

Actually, probably not. Some search gives this datasheet:

https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/DataSheets/LAN8670-1-2-Data-Sheet-60001573.pdf

And page 2 (table 1) shows only revisions A0 (rev0), B1, (rev2), C1 (rev4).
Not sure about why only even revision numbers are released ?

Page 193 (table 10-1) also shows only B1 and C1. So you can be confident that only those exist.

@Ramón, thank you for your work on this driver!

Félix Piédallu

