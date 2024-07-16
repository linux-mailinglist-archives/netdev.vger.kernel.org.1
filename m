Return-Path: <netdev+bounces-111632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C58931E0F
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 02:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978F41C2128F
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 00:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318F581E;
	Tue, 16 Jul 2024 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="sYevkbqa"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7836D193
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 00:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721089849; cv=none; b=jDxLGWovZitkX6QpKB03w0H1K8FH0fVBXLmy90xl8Xi0uRKvKUOVoJS/zqEw6dSNj9WmEAe6v0PeoUxb/Ltxbixb+89NZScYE1/hGJ5kfzfBlqFIZYkc63+HcRvJ1oUNcD4GVw9POv0vGQiemMR2+Qqc9aCnF4k2dip+EA9AUes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721089849; c=relaxed/simple;
	bh=JRKG2XOIEK40lqiLyMdJQ76QSoHEOVEmcSWexooGFGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCvOdFAmhKS78+e6Y0Qekv67snPEld8VjUnqC8q/8FWvbDwL1rOlDUR3KIr93x8BRKM3FkPNrNdt5h/iDKxx2T3f8g7Ov91uR74j4LIXHKkRe2OSPdnKIOH0jZ7yg3Tj3ZGekyfC150EsD4OvLE+1OOH95RSdr7sgbueYjFY36w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=sYevkbqa; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1721089836;
	bh=JRKG2XOIEK40lqiLyMdJQ76QSoHEOVEmcSWexooGFGo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sYevkbqaZ1W6yFYs4iTLKach9rdb6eqmVBTwvnYFbA3/HkZSQACpAFrUWzsobqcTK
	 g8vrK/NjVKYqtxKo6Kc1xRwv6LJOSFuaEfWg4E8rPv1zTGCzjuBe7oBtBCpEG/ZSUX
	 P4IuMkq0vli4el/zkh69+D1ZsJDP0mMAn6vaemvJUoEWWsLxaVMol/DX46wN0x0Bvo
	 XMl5GIoYTz0+PhhN6hJZnCt65zdO845DpavE8krG0+i60IDsc1yd+KUJtvagUFIxty
	 kFtDzCR4ueFrW+f51bs6eO/frSmKit88+61UWR58Ni1PpwnitcIdEwEty8JD689DWy
	 JBAx8jyvU+rCg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id DC36F60078;
	Tue, 16 Jul 2024 00:30:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 8CA01201E4B;
	Tue, 16 Jul 2024 00:30:07 +0000 (UTC)
Message-ID: <a5a5f36f-43f5-4486-b691-8187f6eaa818@fiberby.net>
Date: Tue, 16 Jul 2024 00:30:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] tc: f_flower: add support for matching on
 tunnel metadata
To: Davide Caratti <dcaratti@redhat.com>
Cc: aclaudi@redhat.com, dsahern@kernel.org, echaudro@redhat.com,
 i.maximets@ovn.org, jhs@mojatatu.com, netdev@vger.kernel.org,
 stephen@networkplumber.org
References: <db729874972e2428df9b28323f24d3ec35f453b5.1721064345.git.dcaratti@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <db729874972e2428df9b28323f24d3ec35f453b5.1721064345.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Davide,

Minor documentation consistency nit, otherwise LGTM.

On 7/15/24 5:27 PM, Davide Caratti wrote:
> extend TC flower for matching on tunnel metadata.
> 
> Changes since RFC:
>   - update uAPI bits to Asbjørn's most recent code [1]
>   - add 'tun' prefix to all flag names (Asbjørn)
>   - allow parsing 'enc_flags' multiple times, without clearing the match
>     mask every time, like happens for 'ip_flags' (Asbjørn)
>   - don't use "matches()" for parsing argv[]  (Stephen)
>   - (hopefully) improve usage() printout (Asbjørn)
>   - update man page
> 
> [1] https://lore.kernel.org/netdev/20240709163825.1210046-1-ast@fiberby.net/
> 
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>   include/uapi/linux/pkt_cls.h |  7 +++++++
>   man/man8/tc-flower.8         | 28 ++++++++++++++++++++++++--
>   tc/f_flower.c                | 38 +++++++++++++++++++++++++++++++++++-
>   3 files changed, 70 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
> index 229fc925ec3a..19e25bceb24c 100644
> --- a/include/uapi/linux/pkt_cls.h
> +++ b/include/uapi/linux/pkt_cls.h
> @@ -554,6 +554,9 @@ enum {
>   	TCA_FLOWER_KEY_SPI,		/* be32 */
>   	TCA_FLOWER_KEY_SPI_MASK,	/* be32 */
>   
> +	TCA_FLOWER_KEY_ENC_FLAGS,	/* be32 */
> +	TCA_FLOWER_KEY_ENC_FLAGS_MASK,	/* be32 */
> +
>   	__TCA_FLOWER_MAX,
>   };
>   
> @@ -674,6 +677,10 @@ enum {
>   enum {
>   	TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT = (1 << 0),
>   	TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST = (1 << 1),
> +	TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM = (1 << 2),
> +	TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT = (1 << 3),
> +	TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM = (1 << 4),
> +	TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT = (1 << 5),
>   };
>   
>   enum {
> diff --git a/man/man8/tc-flower.8 b/man/man8/tc-flower.8
> index 6b56640503d5..028f48571be3 100644
> --- a/man/man8/tc-flower.8
> +++ b/man/man8/tc-flower.8
> @@ -106,7 +106,9 @@ flower \- flow based traffic control filter
>   .B l2_miss
>   .IR L2_MISS " | "
>   .BR cfm
> -.IR CFM_OPTIONS " }"
> +.IR CFM_OPTIONS " | "
> +.BR enc_flags
> +.IR ENCFLAG_LIST " }"
>   
>   .ti -8
>   .IR LSE_LIST " := [ " LSE_LIST " ] " LSE
> @@ -131,6 +133,16 @@ flower \- flow based traffic control filter
>   .B op
>   .IR OPCODE "
>   
> +.ti -8
> +.IR ENCFLAG_LIST " := [ " ENCFLAG_LIST "/ ] " ENCFLAG
> +
> +.ti -8
> +.IR ENCFLAG " := { "
> +.BR [no]tuncsum " | "
> +.BR [no]tundf " | "
> +.BR [no]tunoam " | "
> +.BR [no]tuncrit " } "
> +
>   .SH DESCRIPTION
>   The
>   .B flower
> @@ -538,11 +550,23 @@ Match on the Maintenance Domain (MD) level field.
>   .BI op " OPCODE "
>   Match on the CFM opcode field. \fIOPCODE\fR is an unsigned 8 bit value in
>   decimal format.
> +.RE
> +.TP
> +.BI enc_flags " ENCFLAGS_LIST "

^^^ reference to ENCFLAGS_LIST

> +Match on tunnel control flags.
> +.I ENCFLAGS_LIST
> +is a list of the following tunnel control flags:
> +.BR [no]tuncsum ", "
> +.BR [no]tundf ", "
> +.BR [no]tunoam ", "
> +.BR [no]tuncrit ", "
> +each separated by '/'.
> +.TP
>   
>   .SH NOTES
>   As stated above where applicable, matches of a certain layer implicitly depend
>   on the matches of the next lower layer. Precisely, layer one and two matches
> -(\fBindev\fR,  \fBdst_mac\fR and \fBsrc_mac\fR)
> +(\fBindev\fR,  \fBdst_mac\fR, \fBsrc_mac\fR and \fBenc_flags\fR)
>   have no dependency,
>   MPLS and layer three matches
>   (\fBmpls\fR, \fBmpls_label\fR, \fBmpls_tc\fR, \fBmpls_bos\fR, \fBmpls_ttl\fR,
> diff --git a/tc/f_flower.c b/tc/f_flower.c
> index 08c1001af7b4..35ccc3743f46 100644
> --- a/tc/f_flower.c
> +++ b/tc/f_flower.c
> @@ -28,6 +28,7 @@
>   
>   enum flower_matching_flags {
>   	FLOWER_IP_FLAGS,
> +	FLOWER_ENC_DST_FLAGS,
>   };
>   
>   enum flower_endpoint {
> @@ -99,13 +100,16 @@ static void explain(void)
>   		"			ct_label MASKED_CT_LABEL |\n"
>   		"			ct_mark MASKED_CT_MARK |\n"
>   		"			ct_zone MASKED_CT_ZONE |\n"
> -		"			cfm CFM }\n"
> +		"			cfm CFM |\n"
> +		"			enc_flags ENC-FLAGS }\n"

^^^ reference to ENC-FLAGS

>   		"	LSE-LIST := [ LSE-LIST ] LSE\n"
>   		"	LSE := lse depth DEPTH { label LABEL | tc TC | bos BOS | ttl TTL }\n"
>   		"	FILTERID := X:Y:Z\n"
>   		"	MASKED_LLADDR := { LLADDR | LLADDR/MASK | LLADDR/BITS }\n"
>   		"	MASKED_CT_STATE := combination of {+|-} and flags trk,est,new,rel,rpl,inv\n"
>   		"	CFM := { mdl LEVEL | op OPCODE }\n"
> +		"	ENCFLAG-LIST := [ ENCFLAG-LIST/ ]ENCFLAG\n"
> +		"	ENCFLAG := { [no]tuncsum | [no]tundf | [no]tunoam | [no]tuncrit }\n"

Nit: What is ENC-FLAGS? I assume it should have been ENCFLAG-LIST.

For consistency between man and --help, is it singular or plural flags,
and is it with a dash or underscore?


-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

