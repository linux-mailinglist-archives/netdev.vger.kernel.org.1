Return-Path: <netdev+bounces-62777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A77382926F
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 03:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98DA1F26A36
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 02:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9DF15C0;
	Wed, 10 Jan 2024 02:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPPu7cZZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621303C0A
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 02:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-205f223639fso2439005fac.2
        for <netdev@vger.kernel.org>; Tue, 09 Jan 2024 18:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704853582; x=1705458382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E+R2xX+FIqriBoo7t56wIQ9YxjMjCLhe/aGI/TnXo8w=;
        b=ZPPu7cZZkuxuZiP0n8RH/IOWclmi/2kryRK2pHNAsWcTdLWfdMrYi7M3f7gs9UGD6Q
         /lJtEp2gOBxHvrnhWXw0WtS4qNldtrEbY1W02iam1zanzNI+tW+WD/ynpg3NGzvWO74k
         Urv1gwZS03s9a30tZf4p1CmdG69gJDx4XF0EeVGsCv0AhdUwF+Wnl5m4JsFc0idMuAKa
         CmfUq/SICvCpYZ9dOP/V+7YAxSUc96kJkh3KiOWTrYJI5Ed9oKBrat5jdz1noJi07xOA
         rGmZTgqCBXFKCpnZspcP6TtM47s6XtJbzrqrr8LropeAL/LaAoJnDodokmj+27/1k6Th
         qYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704853582; x=1705458382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+R2xX+FIqriBoo7t56wIQ9YxjMjCLhe/aGI/TnXo8w=;
        b=Kz7urGC1886v/GFiaKbkDQGGc8TqTm70O+9I+xPVRHleuCRDhDWFUYLXwd6ikpgVD6
         exyeF6f0vO4z2aYVATDWnMk2C1mIfZdQ1pGhZq+o/HinomGMeOavPYlTd/jnVrAUrlHw
         t0lUbsYDjtrgRojzSY3gDAJiFt1vp0e5xFOj2lHWcuF8oehsicw1nKs1glht9nUfT99Q
         JA/o+G4pfSPvVaFgN4aIFRpWgemnqSRRqF4OOEY0CQp+qBVF91rVpAM2OKgW6zJpr8y5
         zvrJNzXkX46O3fF6FRfoAFJsMJuTKj+3aRyUqwrIeK0D9ziApAdyIEsJDBVVa7Mvy684
         H6hA==
X-Gm-Message-State: AOJu0YxcNW5EOlg8jAIl11nKW//kdHPI411a/RymOTQN5FjB3QGjcNo8
	UCdgq0IvDsv8RXlNGxxEmrC2qa3J369mzmaq
X-Google-Smtp-Source: AGHT+IGxCzL2MLb2Uff1sihLCwm7KhSTbOOKfyiLjiiaFWQEan1+jf7qOMMeF6/HV7d0PVcBuBIMLA==
X-Received: by 2002:a05:6871:8a7:b0:203:ef78:15b9 with SMTP id r39-20020a05687108a700b00203ef7815b9mr29197oaq.0.1704853582257;
        Tue, 09 Jan 2024 18:26:22 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c32-20020a631c20000000b005c66b54476bsm2285127pgc.63.2024.01.09.18.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 18:26:21 -0800 (PST)
Date: Wed, 10 Jan 2024 10:26:18 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: Aahil Awatramani <aahila@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2 net-next v2] bonding: Extending LACP MUX State
 Machine to include a Collecting State.
Message-ID: <ZZ4AShj0fWSiw29D@Laptop-X1>
References: <20240105000632.2484182-1-aahila@google.com>
 <11317.1704418732@famine>
 <ZZtwKFu4GQLQ5AXM@Laptop-X1>
 <26173.1704830028@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26173.1704830028@famine>

On Tue, Jan 09, 2024 at 11:53:48AM -0800, Jay Vosburgh wrote:
> >> 	Please reference the standard in the description; this is
> >> implementing the independent control state machine per IEEE 802.1AX-2008
> >> 5.4.15 in addition to the existing coupled control state machine.
> >
> >The status of IEEE 802.1AX-2008[1] is "Superseded Standard". Maybe we should
> >use IEEE 802.1AX-2020[2].
> >
> >[1] https://standards.ieee.org/ieee/802.1AX/4176/
> >[2] https://standards.ieee.org/ieee/802.1AX/6768/
> 
> 	I'm fine to still reference the 2008 (or 2014) standard even
> though it's superseded; the 2020 standard is much more complicated, and
> I find it harder to follow (particularly for the coupled / independent
> control sections, the older standard explains them more clearly in my
> reading).  Bonding does not implement any of the new things added for
> the 2020 version, so we're not really missing anything.
> 
> 	That said, as long as the citations are for the correct section
> (the numbering is not consistent between versions) any version is
> acceptable.

Got it. Thanks for the comments.

Cheers
Hangbin

