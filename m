Return-Path: <netdev+bounces-292751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDbHGYRvGGoSkAgAu9opvQ
	(envelope-from <netdev+bounces-292751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:38:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2795F5180
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E3DD30E35DF
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7677423158;
	Thu, 28 May 2026 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLst1YZD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sYRS+faM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E6F408013
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984095; cv=none; b=Ou9qmnx0fu7e+FyEQfROD1Mh/EFbc3psZGcgp+ag1TkSfe/9cJIDAZOMWkGmVlCXA0+1/OJQLpAwsRmgzxXNfG+yEqsjYTLlrc2SArm4w74VGhtcPP/Elc0C2K93cwMA6iVhgol/+fsDzKmHDZL1VyJ9by02uuL7m1Q+7vaSf3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984095; c=relaxed/simple;
	bh=/UWIrCDt0JHQs55xLO8CjfD0M54dmvXpB7PRriNg6Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C06bhObDgeRRDWjXYyM5woN4J30VCIyX7BYeMtk52CnovuZH81ChMlNicSftJgYLKGfCW+keVldj2Oj2Zf4ukdY0qxcI/UIl0240wTN4Zgt4JEaJD4NVsOjkQ5KCLzn3BJU9t9y4C+/++e4SRGopf2FVQ4Y3aE4jZ93dNxO5uYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BLst1YZD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sYRS+faM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779984093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cao5gERt16FVWVNp7KK/pfGkUyLMcAKURayz3il4e7o=;
	b=BLst1YZDbtgGN/ok2f2lBiAwsS6SfM5Awb9N5UYoqH0m2HlRM8bIzasri/uRH3DUo6r3z+
	a4xn9+qJm1NHxTQXvsLsTfxAGh/fbuN12HIKUPKeitH70J6Fz5ROJ/+D9Hd0eawusrheHt
	sryOaob5s5EmAM67Zi5m205EPTcH/4g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-pAKCLYI7Nm-LVjDVaoOx8g-1; Thu, 28 May 2026 12:01:32 -0400
X-MC-Unique: pAKCLYI7Nm-LVjDVaoOx8g-1
X-Mimecast-MFC-AGG-ID: pAKCLYI7Nm-LVjDVaoOx8g_1779984091
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fd3449e61so5632655e9.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779984090; x=1780588890; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cao5gERt16FVWVNp7KK/pfGkUyLMcAKURayz3il4e7o=;
        b=sYRS+faMy8VCJJrdTTWEAQVc72ByxCQSTbr4W0kEOQx4tDoywOy56DE+PiW802aKno
         92OGwj+fVbQFUQjnVEfn5lITUfbNMhwgIDVByU5yy3EvQOuyFUotaGa1QGBr3bdBJzu+
         m2fCZHzVSyV8AWlRSznrobru/tqJ9z7KIRoEzjKrekyjFYFVipIVFfJkjsDzA3LmRUzc
         LB8K5A4dRNvs8al1XQf8/3RzNQMJdDDuWifLXzVaF73lysaWRz1lOZIgRE+ztoLHkysf
         KE3RED6ldhaZ+JACZMX2nbofuPM+69f9YzFmK1rusH3r6eUkz+rES00yaQGZ1Nuodx4/
         ZwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779984090; x=1780588890;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cao5gERt16FVWVNp7KK/pfGkUyLMcAKURayz3il4e7o=;
        b=se9UGXzMRLJmPjadmax8aexDFFwTUs4evBgZJqgBswJadgJOLgihwK36or3YzRDIBs
         Ug0xdi8jBTq5nF+LTLnFBYkdY+PPqys85r01iIlk/QVOyULehqAeRn97980I3nVFjB9N
         eA235yP9JtiGubycETDHPp8XMZ5E2vgCJMmbEVE8GVDnywtfzuz0HhxQb6DyriffDC4z
         NlWsnuuPTH3qaUNi1kCQif5GSDjyviGOzH8uK2WHNaLX3l8kOW3eiWll5SFU4YYZdx0J
         svGydNTqG7DK3sHnLhpyV/w43JSGlHCVqVKlZJZsJVuTEPPJy6+gGlsuI8X+DxtodRld
         GGxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+oF5tK3cgGg2xysv5EVpSZGptA1pTg7RigvvNXfpuZBXYc+hsrKp7qJhvR0mNskvXTUIcmn4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKaXWalwJ4VHwGBHMIFayq4icaWqYvleVvzs0DP9MCbF42EQ6V
	OkmXB30qeV8EcUnHrfSUMWi0g1KMG3vVvm59XeEafcYcAdd7J1lHuX0CvEDVdh48zWopeHT5y1a
	1ITFw7lXCyAX1+omgI/OeTxUTxOogFrKwfMNqIfV7mseoS7JulJzDd6q6
X-Gm-Gg: Acq92OHPS9G40MxjcISWee3kuckaDb8xsLsW+CFhWzG9JWO6peyYEphQ3yLgtFtYUL5
	o+a2Q4Lxbu7rY+AHzkVxNm3Y/l5QlHpLX/f0daDLnMsP2EwyRXo7yjB1WuxswredO/opEfYrcvT
	bdq5flkqi/8m1nR6VZ7eeuSyQZgd2G392YXxCQqYzcCfCApO+JVWYykvzrj86XO80dx7BhnB9Gg
	PTNVa9vXIBOF8xKhHqoZ/K0ZSn+UaYASRraU0iV4GA3NSJb3QHvy8d5o6Uwi0KXX3I+0k8JOvLo
	9LFEI7G9XK/H2EUkJEd9+IG+twLnFmCiyMWOBRUQzzWHmXdK0SqoDFBImOZ69zobof6ShvAgllP
	GoRL90jh+RSmQKJvp9R50lQ==
X-Received: by 2002:a5d:5f56:0:b0:44c:e7f6:3a5c with SMTP id ffacd0b85a97d-45ee51f1528mr2934775f8f.0.1779984090433;
        Thu, 28 May 2026 09:01:30 -0700 (PDT)
X-Received: by 2002:a5d:5f56:0:b0:44c:e7f6:3a5c with SMTP id ffacd0b85a97d-45ee51f1528mr2934730f8f.0.1779984089798;
        Thu, 28 May 2026 09:01:29 -0700 (PDT)
Received: from tp ([2a02:29e1:404:f800:9fbc:ecd8:5c1a:509c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5b2bbfsm14995087f8f.32.2026.05.28.09.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 09:01:29 -0700 (PDT)
Date: Thu, 28 May 2026 18:01:27 +0200
From: Beniamino Galvani <bgalvani@redhat.com>
To: =?iso-8859-1?B?zfFpZ28=?= Huguet <ihuguet@redhat.com>
Cc: Stefano Brivio <sbrivio@redhat.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Yumei Huang <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>,
	Justin Iurman <justin.iurman@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <ahhm1-XfnsWyIWDV@tp>
References: <675083b4-e015-4ff3-836c-798e0a971194@suse.de>
 <20260528073849.759da84a@elisabeth>
 <baba855a-7cc9-409e-9c20-6e50f35d255a@suse.de>
 <20260528131250.1352ab48@elisabeth>
 <b21c598b-879c-4f6a-9dc8-27e5c362803b@suse.de>
 <bd669eaf-64dc-4217-bae0-4a531e473762@leemhuis.info>
 <20260528153202.14900687@elisabeth>
 <CACT4ouf5ZqGgb=RO8_7NovLCvYKLKL4vD70dEe6xUODT1UEcSA@mail.gmail.com>
 <20260528165320.15b90ded@elisabeth>
 <CACT4oue2EMM9Kfsm9Jii2rG9ooi=D37PK=8886cpLuBkwhrOxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACT4oue2EMM9Kfsm9Jii2rG9ooi=D37PK=8886cpLuBkwhrOxw@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292751-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,leemhuis.info,suse.de,kernel.org,vger.kernel.org,idosch.org,gmail.com,gibson.dropbear.id.au,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bgalvani@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0F2795F5180
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 05:24:28PM +0200, Íñigo Huguet wrote:
> On Thu, May 28, 2026 at 4:53 PM Stefano Brivio <sbrivio@redhat.com> wrote:
> > I think what's considered UAPI in this case isn't so clear-cut. I guess
> > it would have been pretty hard for anybody not familiar with
> > NetworkManager's codebase to imagine that an application would rely on
> > IPv6 addresses (and only IPv6) to be returned in the reverse order.
> 
> IMHO it's not because an application would rely on the order. It's
> because the order matters, as the first one is considered the primary.
> This is not NetworkManager specific. Or I am mistaken? I'm speaking by
> memory

Yes, exactly. If you do:

 ip addr add dev X 3fff::1/64
 ip addr dev dev X 3fff::2/64

then the old kernel chooses the address that was added last as source
address for outgoing communications. With the new kernel it chooses
the address that was added first.

I think that any script or network management tool that cares about
the source address selection is impacted. Indeed, the commit had
effects on one of the selftests, which had to be modified to change
the order of iproute2 invocations.
 
> > > If the fix must be in NetworkManager, we only need to parse them in
> > > non-reverse order like IPv4, I guess.
> >
> > But that would then require some form of detection, and, at least
> > according to Fernando, isn't the most robust option anyway, as ideally
> > NetworkManager shouldn't rely on the order at all.
> 
> True

Correct, if the new behavior is considered better, there should be a
way to detect which order must be used. Otherwise userspace tools
won't be able to maintain the same behavior with different kernels.

Beniamino


