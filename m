Return-Path: <netdev+bounces-168203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 148A8A3E165
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8BD17F40C
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CB12135D8;
	Thu, 20 Feb 2025 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="aSiBQIAy"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CFF211712;
	Thu, 20 Feb 2025 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070099; cv=none; b=OuIT1lZq+yUNhsm13wbQjsEXOSdiNGCNFHfat75WVkTvziYVU8lx8EBZPX9aV5TyPUcM55ELsHqjNtjm/aGvqwvgDski3HI5/YYv1tKQkTZho4rKoQR/IHMg2KPeziutWN1J7L0Eu8XnyrVyQdN8xYkhjZVS6yTdTiRFfzd+x4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070099; c=relaxed/simple;
	bh=n9Xbwl+fQoGnlHoZ6DhJpTxqftbyrczRb+VyfJeh9I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KG4vlkfCe9H7HOzRUfhycen2Bfkgcpp5lmylKFOJtQb+/svKsoSoqk/RNfGjKq0CYx++G9XqR3FYcRDezbmZunFw/TT8dj9ZyDS1B9Pqp6d5uQM4sRGA79yuXmvAr2e/Pf4vVPnRHhi5P/w63zIX+j/Qo4ZtmLU3gpw6lrUbaZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=aSiBQIAy; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=82dqFK/+I+yQTkdCJUvoXC0E698TJBTXyRzhSQITprs=; b=aSiBQIAyWRInn5J6
	2AlnzNRGerj1SpjtGOt/lUNc0KmzoUmVFTcns2rNreK2O0trQo8mmUPzt55i4lfaGCoHNaV3qwAgv
	NCvD1QPTrY0TlrzT0VLcqbB/oD0GNf1IwpME1WKweamFNPZTQ9POa8fcqqFWxxxDVrhih1ay9wSRp
	pWoxXpwJrVxi1qhX6i4LhUATHx5FwJxVHKDzWrMbiRxbliExqa6SR1J1LuN4KvbqVA/JNKQMvZ5YX
	P23x4CoGzhatFn9x48CnX+aDdjljIJd1UgAS5qVDwJIAzotGTOsTULo2vI5x0mRAXcsSwj6RuOmR4
	o53HzdS2e7cK/inTzg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tl9iW-00HF5U-1b;
	Thu, 20 Feb 2025 16:48:04 +0000
Date: Thu, 20 Feb 2025 16:48:04 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: paul@paul-moore.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] netlabel: Remove unused cfg_calipso funcs
Message-ID: <Z7dcxAYj_jsG9WL6@gallifrey>
References: <20250220140808.71674-1-linux@treblig.org>
 <aa6c6f4c-7d46-4e7e-bafc-f042436f47b6@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aa6c6f4c-7d46-4e7e-bafc-f042436f47b6@schaufler-ca.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:46:41 up 288 days,  4:00,  1 user,  load average: 0.02, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Casey Schaufler (casey@schaufler-ca.com) wrote:
> On 2/20/2025 6:08 AM, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > netlbl_cfg_calipso_map_add(), netlbl_cfg_calipso_add() and
> > netlbl_cfg_calipso_del() were added in 2016 as part of
> > commit 3f09354ac84c ("netlabel: Implement CALIPSO config functions for
> > SMACK.")
> >
> > Remove them.
> 
> Please don't. The Smack CALIPSO implementation has been delayed
> for a number of reasons, some better than others, but is still on
> the roadmap.

Hmm OK.
If it makes it to 10 years next year then perhaps it should hold
a birthday party!

Dave

> 
> >
> > (I see a few other changes in that original commit, whether they
> > are reachable I'm not sure).
> >
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >  include/net/netlabel.h       |  26 -------
> >  net/netlabel/netlabel_kapi.c | 133 -----------------------------------
> >  2 files changed, 159 deletions(-)
> >
> > diff --git a/include/net/netlabel.h b/include/net/netlabel.h
> > index 02914b1df38b..37c9bcfd5345 100644
> > --- a/include/net/netlabel.h
> > +++ b/include/net/netlabel.h
> > @@ -435,14 +435,6 @@ int netlbl_cfg_cipsov4_map_add(u32 doi,
> >  			       const struct in_addr *addr,
> >  			       const struct in_addr *mask,
> >  			       struct netlbl_audit *audit_info);
> > -int netlbl_cfg_calipso_add(struct calipso_doi *doi_def,
> > -			   struct netlbl_audit *audit_info);
> > -void netlbl_cfg_calipso_del(u32 doi, struct netlbl_audit *audit_info);
> > -int netlbl_cfg_calipso_map_add(u32 doi,
> > -			       const char *domain,
> > -			       const struct in6_addr *addr,
> > -			       const struct in6_addr *mask,
> > -			       struct netlbl_audit *audit_info);
> >  /*
> >   * LSM security attribute operations
> >   */
> > @@ -561,24 +553,6 @@ static inline int netlbl_cfg_cipsov4_map_add(u32 doi,
> >  {
> >  	return -ENOSYS;
> >  }
> > -static inline int netlbl_cfg_calipso_add(struct calipso_doi *doi_def,
> > -					 struct netlbl_audit *audit_info)
> > -{
> > -	return -ENOSYS;
> > -}
> > -static inline void netlbl_cfg_calipso_del(u32 doi,
> > -					  struct netlbl_audit *audit_info)
> > -{
> > -	return;
> > -}
> > -static inline int netlbl_cfg_calipso_map_add(u32 doi,
> > -					     const char *domain,
> > -					     const struct in6_addr *addr,
> > -					     const struct in6_addr *mask,
> > -					     struct netlbl_audit *audit_info)
> > -{
> > -	return -ENOSYS;
> > -}
> >  static inline int netlbl_catmap_walk(struct netlbl_lsm_catmap *catmap,
> >  				     u32 offset)
> >  {
> > diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> > index cd9160bbc919..13b4bc1c30ec 100644
> > --- a/net/netlabel/netlabel_kapi.c
> > +++ b/net/netlabel/netlabel_kapi.c
> > @@ -394,139 +394,6 @@ int netlbl_cfg_cipsov4_map_add(u32 doi,
> >  	return ret_val;
> >  }
> >  
> > -/**
> > - * netlbl_cfg_calipso_add - Add a new CALIPSO DOI definition
> > - * @doi_def: CALIPSO DOI definition
> > - * @audit_info: NetLabel audit information
> > - *
> > - * Description:
> > - * Add a new CALIPSO DOI definition as defined by @doi_def.  Returns zero on
> > - * success and negative values on failure.
> > - *
> > - */
> > -int netlbl_cfg_calipso_add(struct calipso_doi *doi_def,
> > -			   struct netlbl_audit *audit_info)
> > -{
> > -#if IS_ENABLED(CONFIG_IPV6)
> > -	return calipso_doi_add(doi_def, audit_info);
> > -#else /* IPv6 */
> > -	return -ENOSYS;
> > -#endif /* IPv6 */
> > -}
> > -
> > -/**
> > - * netlbl_cfg_calipso_del - Remove an existing CALIPSO DOI definition
> > - * @doi: CALIPSO DOI
> > - * @audit_info: NetLabel audit information
> > - *
> > - * Description:
> > - * Remove an existing CALIPSO DOI definition matching @doi.  Returns zero on
> > - * success and negative values on failure.
> > - *
> > - */
> > -void netlbl_cfg_calipso_del(u32 doi, struct netlbl_audit *audit_info)
> > -{
> > -#if IS_ENABLED(CONFIG_IPV6)
> > -	calipso_doi_remove(doi, audit_info);
> > -#endif /* IPv6 */
> > -}
> > -
> > -/**
> > - * netlbl_cfg_calipso_map_add - Add a new CALIPSO DOI mapping
> > - * @doi: the CALIPSO DOI
> > - * @domain: the domain mapping to add
> > - * @addr: IP address
> > - * @mask: IP address mask
> > - * @audit_info: NetLabel audit information
> > - *
> > - * Description:
> > - * Add a new NetLabel/LSM domain mapping for the given CALIPSO DOI to the
> > - * NetLabel subsystem.  A @domain value of NULL adds a new default domain
> > - * mapping.  Returns zero on success, negative values on failure.
> > - *
> > - */
> > -int netlbl_cfg_calipso_map_add(u32 doi,
> > -			       const char *domain,
> > -			       const struct in6_addr *addr,
> > -			       const struct in6_addr *mask,
> > -			       struct netlbl_audit *audit_info)
> > -{
> > -#if IS_ENABLED(CONFIG_IPV6)
> > -	int ret_val = -ENOMEM;
> > -	struct calipso_doi *doi_def;
> > -	struct netlbl_dom_map *entry;
> > -	struct netlbl_domaddr_map *addrmap = NULL;
> > -	struct netlbl_domaddr6_map *addrinfo = NULL;
> > -
> > -	doi_def = calipso_doi_getdef(doi);
> > -	if (doi_def == NULL)
> > -		return -ENOENT;
> > -
> > -	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
> > -	if (entry == NULL)
> > -		goto out_entry;
> > -	entry->family = AF_INET6;
> > -	if (domain != NULL) {
> > -		entry->domain = kstrdup(domain, GFP_ATOMIC);
> > -		if (entry->domain == NULL)
> > -			goto out_domain;
> > -	}
> > -
> > -	if (addr == NULL && mask == NULL) {
> > -		entry->def.calipso = doi_def;
> > -		entry->def.type = NETLBL_NLTYPE_CALIPSO;
> > -	} else if (addr != NULL && mask != NULL) {
> > -		addrmap = kzalloc(sizeof(*addrmap), GFP_ATOMIC);
> > -		if (addrmap == NULL)
> > -			goto out_addrmap;
> > -		INIT_LIST_HEAD(&addrmap->list4);
> > -		INIT_LIST_HEAD(&addrmap->list6);
> > -
> > -		addrinfo = kzalloc(sizeof(*addrinfo), GFP_ATOMIC);
> > -		if (addrinfo == NULL)
> > -			goto out_addrinfo;
> > -		addrinfo->def.calipso = doi_def;
> > -		addrinfo->def.type = NETLBL_NLTYPE_CALIPSO;
> > -		addrinfo->list.addr = *addr;
> > -		addrinfo->list.addr.s6_addr32[0] &= mask->s6_addr32[0];
> > -		addrinfo->list.addr.s6_addr32[1] &= mask->s6_addr32[1];
> > -		addrinfo->list.addr.s6_addr32[2] &= mask->s6_addr32[2];
> > -		addrinfo->list.addr.s6_addr32[3] &= mask->s6_addr32[3];
> > -		addrinfo->list.mask = *mask;
> > -		addrinfo->list.valid = 1;
> > -		ret_val = netlbl_af6list_add(&addrinfo->list, &addrmap->list6);
> > -		if (ret_val != 0)
> > -			goto cfg_calipso_map_add_failure;
> > -
> > -		entry->def.addrsel = addrmap;
> > -		entry->def.type = NETLBL_NLTYPE_ADDRSELECT;
> > -	} else {
> > -		ret_val = -EINVAL;
> > -		goto out_addrmap;
> > -	}
> > -
> > -	ret_val = netlbl_domhsh_add(entry, audit_info);
> > -	if (ret_val != 0)
> > -		goto cfg_calipso_map_add_failure;
> > -
> > -	return 0;
> > -
> > -cfg_calipso_map_add_failure:
> > -	kfree(addrinfo);
> > -out_addrinfo:
> > -	kfree(addrmap);
> > -out_addrmap:
> > -	kfree(entry->domain);
> > -out_domain:
> > -	kfree(entry);
> > -out_entry:
> > -	calipso_doi_putdef(doi_def);
> > -	return ret_val;
> > -#else /* IPv6 */
> > -	return -ENOSYS;
> > -#endif /* IPv6 */
> > -}
> > -
> >  /*
> >   * Security Attribute Functions
> >   */
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

