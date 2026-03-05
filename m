Return-Path: <netdev+bounces-264396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJX0CRuGqWkd9gAAu9opvQ
	(envelope-from <netdev+bounces-264396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:33:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85161212A01
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBD09303D2CA
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 13:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5243A4F5C;
	Thu,  5 Mar 2026 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+YydmEL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BA03A1E73
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772717550; cv=none; b=lQC/qYD0DprJ2N3iCN1mpnF5nZ1kWjs5i9lX+M1a64vuaZm2ChTGONwHo31xz0SF9ADzbX2xB+MtfECmLSFKTGwUPKygRXsoSSfFNAVKfFcXYLKh5cesyGuDD1i1elhDi0Pso4B4hvju4VeApWppBf/5j8iy3WhS6wiA0fjOtu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772717550; c=relaxed/simple;
	bh=C2n6OMqiUBPSfQmiMUueiTzMNpaAqJocbnsxeFPmiUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGkSLgYOxsgdUr+wyzNA5xoD2LEkhL/aO8dKuZ9zWj+YTWg7FxImSA/PkkGChjDWCDNMEPcg+364Xr50gl3axWK09HK7XOBr3UClehTCndY9qKisLM3EwNtSpn2kTLOcJiAJQvNEKmGyrMU4WXg4jQ+txLlnYxBZP+iELdWhdm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+YydmEL; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79801df3e21so73922447b3.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 05:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772717548; x=1773322348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z/MQdRS2uWUXUzzh9zR/GPrej4iJqLveQqqBD5qeAtg=;
        b=h+YydmELHhvDdVuLSSFex+hjeuKsDfjsOmjtYGoqStCXsL9TjWM3pc+ggBoCrLCnRN
         EK1WXVfuHChShm9q31fW75JnM7VPu83PiXzUJMMPtkmyKbgj3tMezhlCtm9A3s0SUiau
         cetcKbEJUFUHCxmtlFVO0vRLTCLVfLezx5YTvGocNwE295uzwutbaO+/cHRr3GsokQxc
         239p0zQPanfdp5QevUfWdkgDQfywvem/ytz6J3VTq537du4NWbAhBGzMMe+IUOx22B6p
         fyWCpTofG+suhQbN3kZ98orur91xEneiMk/Vir3+/25GcN9Z+7dfhMH3HG1tiMMfjj0z
         TOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772717548; x=1773322348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/MQdRS2uWUXUzzh9zR/GPrej4iJqLveQqqBD5qeAtg=;
        b=aDcn/yRrLGVbd3IDeCq52Vq/gKtlDVF3uB1SmJEp1kKBi8BvsN8w3kkg0ghkf6iYni
         EfevRKX357vgpVNGZELjttXsj5WIPu3RNi3E1HN/05DAg2sayqm8P9xCgFhcu3Tr1H31
         G8yQLWFpZfVs4F8zraYGzg+H9K4pWf3rRqHdMsbOhKKoQVF7Vo2zm2XJ3m6JrW7SbqUy
         fMV+PoDvm1WKqtxwuedCy4WY6JvvzHv4ItmqUJoH9zLWFGMhFWhSJ+CCO9a1wMcFgGw5
         zeAgUKZURiQmlH8mdUDOTduD+hhmfYd3hz1RiRzBcWUa85y5WT7pm6jEhU/OnCfbZlP1
         Eulw==
X-Forwarded-Encrypted: i=1; AJvYcCU8hukY81zMlfcwYj6e4iuOWNHdra75gmEqFXH9eyCPCCKxTMjbep2uzo5ikjwU/uaHVOTBFVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkdyL0xckQyzjHI6USH5yKB297U4Ix+gV/gtbkXGKIn3fhN3Cy
	88yl8iWAWvXdOijTY8hYuMe+PuZK7p7dI5t0vY5Pg2l6n9BWidwBZi3/
X-Gm-Gg: ATEYQzy5Inxesb9oIxhX65Z7DytEChu/9a6McQcVkOvlJbGSJ7/bXv1pKpEz0O9c7U9
	2twbt4FZA4uM5uJ198zPWwgihmKIcCNihjymxW56feFlWvJgVIm2Zttw/uvaOoMx+vatnmmcsQ+
	cKjdy88NCXeVUpzzexbRrjvrW8dAzz9ZpCzXxtWhFa1NCDlBr/6pgLyQbIUOOIeyxp17pJ6dy0s
	EEutK0XXFgtr1CzVD+3nVCKwofh5qUaBVdwbFlMBojEu3Llo9pDskDrVxEfjRXQBKB6ycpEA3LB
	MxCxZvdNHpPCsj3nPJs4JtyN9LzyRJ1rCK1l+29U6XdpRIPobUSPw+hPsxzgu3h3BtbQBBexq+9
	PZw9iKKEimVhALnoKr3co93/d4pT31NO97X727qpIaQ67leto/W75+0xdX74XCIOXvBN9ZaEsZ9
	zveEobnXfQmNDXmifU/xr5tOpfV4g6kjJ1i3FnqRIkqa0Xxqo=
X-Received: by 2002:a05:690c:dc5:b0:797:a162:f7cb with SMTP id 00721157ae682-798c6cd975bmr46986367b3.48.1772717547914;
        Thu, 05 Mar 2026 05:32:27 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:55::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876bf8103sm88645747b3.27.2026.03.05.05.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 05:32:27 -0800 (PST)
Date: Thu, 5 Mar 2026 05:32:25 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, sgarzare@redhat.com, netdev@vger.kernel.org,
	mkutsevol@meta.com, thevlad@meta.com, christinewang@meta.com
Subject: Re: Stable backport request: vsock namespace support for 6.18.y
Message-ID: <aamF6ZJswoMkrFWr@devvm11784.nha0.facebook.com>
References: <aajWMBoSgXafmw8b@devvm11784.nha0.facebook.com>
 <2026030538-nearest-dumpster-481e@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026030538-nearest-dumpster-481e@gregkh>
X-Rspamd-Queue-Id: 85161212A01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264396-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,devvm11784.nha0.facebook.com:mid]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 08:15:12AM +0100, Greg KH wrote:
> On Wed, Mar 04, 2026 at 05:02:48PM -0800, Bobby Eshleman wrote:
> > I realize this may be a long-shot/big ask, as these patches definitely
> > fall outside of the 100-line diff limit and it is a very new security
> > feature for vsock.
> 
> It's a new security feature, if you wish to have that, please just use a
> newer kernel release.
> 
> sorry,
> 
> greg k-h

I understand. Thank you for the consideration.

Best,
Bobby

