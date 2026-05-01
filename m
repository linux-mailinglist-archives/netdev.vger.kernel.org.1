Return-Path: <netdev+bounces-283213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NrVMh/E9GnwEQIAu9opvQ
	(envelope-from <netdev+bounces-283213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:17:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C9E4AD85E
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEED23011A50
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 15:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3913B2FF8;
	Fri,  1 May 2026 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="bAdiAGXS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CDF1B7910
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777648667; cv=none; b=m+uwuc/IG7sGsAwHBocfkmDAUbYmSMBPa0dGsER37FI+4Jgk9rYyd7p/JdL05UbTLUitw7NNEsixt2va+lms1RwKktlpTBTvb2lfOM5PjRg9WAM0Y6+nNrX8pCCXLuOI4bX5cRNdpaqKFfDFD0epI2948bbMvEaYPDGdsRQ2C64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777648667; c=relaxed/simple;
	bh=LdoEx+7+YsIaJMBXDB1izNtomsJhVxmjZ5uqOZJxCQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgu6syt2plopZivkBUIGvC0lVIT7kL9Q2df6A/hVHqlUUSmxRXda2cpHi2my+JfYR1HkR2WUUmdTvNRiaUgJneMEXVlLhokyueLEJscYKBpGza0FxzLlPCHLeByJasEF0Y84MZPv33z2p2/i+BUf8Y1AXBbtOYg8yjj+AdjDYOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=bAdiAGXS; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4232323a7daso884243fac.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 08:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777648665; x=1778253465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Yg2qte8ForkpKzIoM9NgEUVnJBrsjr2s4cXmoJAZkY=;
        b=bAdiAGXSu5BZeb3Wx71Y90ZsdAZ2s3pedFmxV/kcQSmkNp0LadI9JHuhOj268FQWRa
         RNLSiZe30lydKIUghBjgAYUsh5O9xS0sSZGJ4CsRwDVP70Zzl/Uj/28a09wpCnsXIWow
         vp10ck2oP7Ib4b7JKfGzST6XMWqjDCTM3Xf3KWbgx9v/BE5aNSmYS4Jk/x9wnKp2U9Lw
         Sl03+SIQTiegZ7SPBgjkZaWncYDpDvddt473F3on/PcmixhSdsr/SmxWzYV+dIk8GIwV
         ibjNbODyIdxlQoKa33fZO4tJJ8IH8Lsr0mImqcnWSsSAy132Q0aL0eeUBvTCjWW9PNfZ
         5P1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777648665; x=1778253465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Yg2qte8ForkpKzIoM9NgEUVnJBrsjr2s4cXmoJAZkY=;
        b=PETT0T+0Wtr3e8hSjWoDEtEY/UkB66TUSipBiqCrL268X3sM7VH9/Rb4pox1PdR3SB
         5/3gW3JOBCPD4f7bZRsU6JoGZkzb/iSvnPKxOLWt1sqIc6FAczpFDrAiGjeIaBvG4HpN
         a2jVwPB8e0QlqKb+lLAdrO7H0nwqTPtAS+1E1ss+zkGLr4Cn/QmnQGd9trs07vcLgc45
         EKrMkDcKFousjgvmHRDwMsc2i3vMW31+DJm3LR2VwhQ0aWJN3duyxK8ATFdPnCmbWLv+
         mwlM9ZkkDeXWh5hyVphn7hPvM5sQdGfIlGJOqzY5oTXTD08IWdec0Lp5n7hJISmC/Npw
         al0w==
X-Gm-Message-State: AOJu0Yz5iTKQZwocFcoZ3MT+ATXFv+9d/jb3sJU4UvZ9799EIfat761n
	GLK0mt0nEc7Lh4Y6nts8LDzXMcLZw25NM76uvVSW0KdWBZnqWLpvg//cPcZbY8P0M0A=
X-Gm-Gg: AeBDieuz53kzjyABphyM0BHcXyY+rcJVjNsiKwokUf2WZ+LLX5g+jCtH9lANtJby0fB
	6zWuouX6DtTBDFSN+Nlw3MpL5j2+uG0mFlo+0mWDr12/SVngFlw6HUKm7535l1lNR82K6pSC6ek
	ix92gQr2NcUrttKKzRMAPhwlfXb93Zd8NJdCVsfNGyYt2iI03465N15Xzkfn3tgfA4sOckigM3Z
	yYVh/5RlgQb5kS4X0aaUAQjHCxgyJE6rxt1F8sbgYM4puvK/L18ZFzFjdgBSF1mOIFZvp2606bq
	HmVKaa7JuQnqvlykTbSHD8xLFbkSlLVFsEQver1GahNXbaHT4mMO2o6yhUOFtM11EdbuvzdGSj6
	rxSBUp55DIxweP1v7iF6x/0/sc31okV32+E7kGPjClw/uzd2lT0/gk2WR2McvjDrifG/UHkuPSI
	UBQI2CZ/waN6w722dw/gbLISenKFhzuvpkhutStbUu23aUxb95Jtfe7AzD
X-Received: by 2002:a05:6871:606:b0:417:33a7:1032 with SMTP id 586e51a60fabf-43433bc7fb0mr4031552fac.25.1777648664522;
        Fri, 01 May 2026 08:17:44 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43454942dc1sm2648451fac.5.2026.05.01.08.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 08:17:44 -0700 (PDT)
Date: Fri, 1 May 2026 08:17:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, ernis@linux.microsoft.com
Subject: Re: [PATCH iproute2-next 0/5] netshaper: Extend netshaper support
Message-ID: <20260501081741.0e07ed4f@phoenix.local>
In-Reply-To: <20260501011611.3533573-1-mohsin.bashr@gmail.com>
References: <20260501011611.3533573-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 36C9E4AD85E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283213-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,phoenix.local:mid,meta.com:email]

On Thu, 30 Apr 2026 18:16:06 -0700
Mohsin Bashir <mohsin.bashr@gmail.com> wrote:

> From: Mohsin Bashir <hmohsin@meta.com>
> 
> This series extends the netshaper CLI with missing parameter support
> and adds the group command for building scheduling hierarchies.
> 
> The existing netshaper tool only supports setting bw-max on individual
> shapers. This series adds the remaining shaper attributes (bw-min,
> weight, priority) needed for TX scheduling, and introduces the
> group command which ties leaf shapers to a parent node in a single
> operation.
> 
> Mohsin Bashir (5):
>   netshaper: Extract parse_scope() and parse_rate() helpers
>   netshaper: Add bw-min and weight parameter support
>   netshaper: Extend show output with parent, bw-min and weight
>   netshaper: Make handle id optional for node scope
>   netshaper: Add group command for creating scheduling hierarchies
> 
>  netshaper/netshaper.c | 398 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 324 insertions(+), 74 deletions(-)
> 

AI review liked the patch but found a JSON break
As always there are some noise things here.
Like the suggestion about noreturn attribute.

Subject: Re: [PATCH iproute2] netshaper: Add group command and parameter support

On Thu, 30 Apr 2026, Mohsin Bashir wrote:
> This series adds netshaper support for scheduling hierarchies, bw-min/weight
> parameters, and improved output formatting.

Overall the patches look good and follow most iproute2 conventions properly.
I especially appreciate that all new code correctly uses strcmp() instead of
matches() for argument parsing.

However, there are a few minor issues that should be addressed:

> @@ -47,55 +54,98 @@ static const char *net_shaper_scope_names[NET_SHAPER_SCOPE_MAX + 1] = {
>  static void print_netshaper_attrs(struct nlmsghdr *answer)
> [...]
> +	printf("\n");
>  }

The raw printf("\n") at the end of print_netshaper_attrs() breaks JSON output.
All output should use the print_XXX() helpers to maintain proper JSON formatting.
This should be:

	print_nl();

or handled by the print functions themselves. The print helpers ensure that
JSON output remains valid when the -j flag is used.

> @@ -103,13 +153,14 @@ static int do_cmd(int argc, char **argv, int cmd)
> [...]
>  	while (argc > 0) {
>  		if (strcmp(*argv, "dev") == 0) {
>  			NEXT_ARG();
>  			ifindex = ll_name_to_index(*argv);

In do_cmd(), the return value of ll_name_to_index() is not properly validated.
When the device doesn't exist, this function returns 0. The code should check:

		ifindex = ll_name_to_index(*argv);
		if (ifindex == 0) {
			fprintf(stderr, "Device \"%s\" not found\n", *argv);
			return -1;
		}

This validation is correctly done in do_group() but missing in do_cmd().

> @@ -31,13 +31,20 @@ static void usage(void)
>  {
>  	fprintf(stderr,
>  		"Usage: netshaper [ OPTIONS ] { COMMAND | help }\n"

The usage() function should be marked with __attribute__((noreturn)) as per
iproute2 coding conventions:

static void usage(void) __attribute__((noreturn));

static void usage(void)
{
	...
	exit(-1);
}

This helps the compiler with optimization and static analysis.

These are all minor issues in an otherwise well-structured patch series.
The code properly uses designated initializers, validates input with
appropriate helpers, and follows the error handling patterns correctly.

With these small fixes, the series would be ready for inclusion.

Best regards

